from enum import IntEnum

from common.Global import *
from common.KLine import KLine
from markets.FuturesPosition import FuturesPosition
from markets.Side import Side


class OrderType(IntEnum):
    MAKER_START = 0,  # maker under this

    TAKE_PROFIT_LIMIT = 1,
    STOP_LOSS_LIMIT = 1,
    LIMIT_LOWER = 3,
    LIMIT_HIGHER = 4,

    TAKER_START = 5,  # taker under this
    MARKET = 6,
    TAKE_PROFIT_MARKET = 8,
    STOP_LOSS_MARKET = 9,

    @staticmethod
    def priority(order_type):
        if order_type == OrderType.MARKET:
            return 0
        if order_type == OrderType.STOP_LOSS_MARKET:
            return 1
        else:
            return 2


# Only supports non-hedge mode. And only one position shall exist.
# Only supports MAKET order partially.
class FuturesOrder:
    order_id = 0

    def __init__(self, account):
        self.side: Side = Side.BUY  # 1 for buy, -1 for sell
        self.unrealized_pnl = 0
        self.leverage = 1
        self.trigger_price = None
        self.margin = None
        self.size = None
        self.is_filled = False
        self.account = account
        self.timestamp = None
        self.type = None
        self.fee = 0
        self.is_cancel = False

        FuturesOrder.order_id += 1
        self.order_id = FuturesOrder.order_id

    def check_order(self):
        if __name__ == '__main__':
            if self.type == OrderType.MARKET:
                if self.account.get_position() is not None:
                    raise Exception("Order cannot be placed, position existed")
                if self.account.balance < self.margin:
                    raise Exception("Order cannot be placed, insufficient balance")
            else:
                if self.account.get_position() is None:
                    raise Exception("Order not exist")

    def open(self, side, trigger_price, margin, order_type: OrderType, timestamp, leverage=1):
        self.side = side
        self.trigger_price = trigger_price
        self.margin = margin
        self.leverage = leverage
        self.timestamp = timestamp
        self.type = order_type
        self.size = margin / trigger_price

        if self.type < OrderType.TAKER_START:
            raise Exception("NOT SUPPORTED NOW")

        self.check_order()

    def fill(self):
        self.is_filled = True
        self.calc_fee(self.margin * self.leverage)

        if self.type == OrderType.MARKET and self.account.get_position() is None:
            position = FuturesPosition(self.trigger_price, self.margin, self.margin / self.trigger_price * self.side,
                                       self.timestamp, self.leverage)
            self.account.add_position(position)
        elif self.type == OrderType.MARKET and self.account.get_position() is not None:
            position = self.account.get_position()
            position.close(self.trigger_price)
            self.account.remove_position()

        self.account.remove_order(self)

    def calc_fee(self, execute_amount):
        if self.type > OrderType.TAKER_START:
            self.fee += execute_amount * Config.TAKER_FEE
        else:
            self.fee += execute_amount * Config.MAKER_FEE
            raise Exception("NOT SUPPORTED RIGHT NOW")

    def update_price(self, price: KLine or None):
        if self.type < OrderType.MAKER_START:
            raise Exception("NOT SUPPORTED RIGHT NOW")

        if self.type == OrderType.MARKET:
            assert False, "Not possible"

        acting_price = self.get_acting_benifit_price(price)
        if self.__is_triggering_on_acting_price(acting_price) and self.account.get_position() is not None:
            self.account.get_position().close(acting_price)
            self.calc_fee(acting_price * self.size)
            self.account.remove_position()
            self.is_filled = True
            self.account.remove_order(self)

    def get_acting_benifit_price(self, price: KLine):
        if self.type == OrderType.TAKE_PROFIT_MARKET:
            return max(price.low, self.trigger_price) if self.side == Side.BUY else min(price.high, self.trigger_price)
        elif self.type == OrderType.STOP_LOSS_MARKET:
            return min(price.low, self.trigger_price) if self.side == Side.BUY else max(price.high, self.trigger_price)
        else:
            raise Exception("NOT SUPPORTED")

    def __is_triggering_on_acting_price(self, acting_price):  # todo TEST IT
        if self.type == OrderType.TAKE_PROFIT_MARKET:
            if self.side == Side.SELL:
                return self.trigger_price <= acting_price
            else:
                return self.trigger_price >= acting_price
        elif self.type == OrderType.STOP_LOSS_MARKET:
            if self.side == Side.SELL:
                return self.trigger_price >= acting_price
            else:
                return self.trigger_price <= acting_price
        else:
            raise Exception("NOT SUPPORTED")

    def stats(self):
        return {
            "margin": self.margin,
            "leverage": self.leverage,
            "filled": self.is_filled,
            "unrealized_pnl": self.unrealized_pnl,
            "timestamp": str(self.timestamp),
            "order_id": self.order_id,
            "type": self.type,
            "fee": self.fee,
            "price": self.trigger_price,
            "side": self.side,
            "canceled": self.is_cancel,
        }
