from markets.FuturesOrder import *
from markets.SimuMarkets import SimuMarket


class FuturesAccount:

    def __init__(self, balance, market: SimuMarket):
        self.balance = balance
        self.order_list = []
        self.position = None  # LATER, support hedge mode
        self.market = market
        self.timestamp = None

    def open_order(self, side: Side, margin, price, order_type, leverage=1):
        if self.position is not None:
            if self.position.side == side and self.balance < margin:
                raise Exception("Insufficient balance")
            elif margin is None:
                margin = self.position.balance(price)
            elif self.position.balance(price) < margin:
                raise Exception(f"Insufficient position margin, {margin} > {self.position.balance(price)}")

        order = FuturesOrder(self)

        if order_type == OrderType.MARKET:
            price = self.market.get_price().close

        timestamp = self.market.get_price().timestamp

        order.open(side, price, margin, order_type, timestamp, leverage)
        self.order_list.append(order)
        if self.position is None:
            self.balance -= order.margin
        DATALOG.add_order(order.stats())

        if order_type == OrderType.MARKET:
            order.fill()

        return order

    def get_position(self) -> FuturesPosition:
        return self.position

    def add_position(self, position):
        self.position = position
        DATALOG.add_position(self.position.stats())

    def remove_position(self):
        self.balance += self.position.balance()
        DATALOG.add_position(self.position.stats())
        self.position = None

    def remove_order(self, order):
        if order in self.order_list:
            self.balance -= order.fee
            DATALOG.add_order(order.stats())
            return self.order_list.remove(order)
        else:
            assert False, "Order not found"

    def remove_all_order(self):
        for order in self.order_list:
            order.is_cancel = True
            DATALOG.add_order(order.stats())
        self.order_list = []

    def update_price(self, price: KLine):
        self.timestamp = price.timestamp
        for order in sorted(self.order_list, key=lambda x: OrderType.priority(x.type)):
            order.update_price(price)
            DATALOG.add_order(order.stats())

        if self.position is not None:
            close, _ = self.position.update_price(price)
            DATALOG.add_position(self.position.stats())
            if close:
                self.balance += self.position.balance()
                self.position = None

        DATALOG.add_account(self.stats())

    def __position_balance(self):
        if self.get_position() is not None:
            return self.position.balance()
        else:
            return 0

    def stats(self):
        return {
            "position": self.get_position() is not None,
            "orders": len(self.order_list),
            "balance": self.balance,
            "unrelized_balance": self.balance + self.__position_balance(),
            "timestamp": self.timestamp,
        }
