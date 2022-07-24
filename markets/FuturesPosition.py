from common.KLine import KLine
from Side import Side


class FuturesPosition:
    def __init__(self, entry_price, margin, size, open_timestamp, account, leverage=1):
        self.max_gain = 0
        self.leverage = leverage
        self.entry_price = entry_price
        self.size = size
        self.side = Side.BUY if self.size > 0 else Side.SELL
        self.is_open = True
        self.margin = margin
        self.unrealized_pnl = 0
        self.update_timestamp = open_timestamp
        self.account = account
        self.max_withdraw = 0

        self.account.add_position(self)

    def set_levearge(self, leverage):
        raise Exception("NOT supported yet")
        # self.leverage = leverage

    def __calc_pnl(self, end_price):
        price_diff = end_price - self.entry_price
        unrealized_pnl = (price_diff * self.margin) * self.side * self.leverage
        return unrealized_pnl

    def calc_unrelized_pnl(self, price: KLine):
        if not self.is_open:
            raise Exception("Order is not init.")

        self.update_timestamp = price.timestamp
        # todo, support multiple orders

        self.unrealized_pnl = self.__calc_pnl(price.close)

    def __calc_max_withdrawl(self, price: KLine):
        if self.size < 0:
            return self.__calc_pnl(price.high)
        if self.size > 0:
            return self.__calc_pnl(price.low)

        assert False  # should never go here

    def __calc_max_unreliazed_margin(self, price: KLine):
        if self.size > 0:
            return self.__calc_pnl(price.high)
        if self.size < 0:
            return self.__calc_pnl(price.low)

        assert False  # should never go here

    # update price, and return position is closed, and current balance.
    def update_price(self, price: KLine) -> (bool, float):
        self.unrealized_pnl = self.calc_unrelized_pnl(price)
        self.max_withdraw = self.__calc_max_withdrawl(price)
        if self.max_withdraw + self.margin <= 0:
            self.close()
            return True, self.balance()
        self.max_gain = self.__calc_max_unreliazed_margin(price)

        return False, self.balance()

    def stats(self):
        return {
            "margin": self.margin,
            "leverage": self.leverage,
            "unrealized_pnl": self.unrealized_pnl,
            "max_withdrawl": self.max_withdraw,
            "max_gain": self.max_gain,
            "timestamp": self.update_timestamp,
        }

    def balance(self):
        return self.margin + self.unrealized_pnl

    def close(self):
        self.is_open = False
        return self.balance()
