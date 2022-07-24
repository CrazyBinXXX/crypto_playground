from markets.FuturesOrder import *


class FuturesAccount:

    def __init__(self, balance, market):
        self.balance = balance
        self.order_list = []
        self.position = None  # LATER, support hedge mode
        self.market = market

    def open_order(self, side: Side, margin, price, order_type, leverage=1):
        if self.position is not None:
            if self.position.side == side and self.balance < margin:
                raise Exception("Insufficient balance")
            elif self.position.balance(price) < margin:
                raise Exception(f"Insufficient position margin, {margin} > {self.position.balance(price)}")

        order = FuturesOrder(self)

        order.open(side, price, margin, order_type, leverage)
        self.order_list.append(order)
        if self.position is None:
            self.balance -= order.margin

        order.update_price(None)

        return order

    def get_position(self) -> FuturesPosition:
        assert self.position is not None, "Position is None. This is a bug."
        return self.position

    def add_position(self, position):
        self.position = position

    def remove_position(self):
        self.balance += self.position.balance()
        self.position = None

    def remove_order(self, order):
        if order in self.order_list:
            self.balance -= order.fee
            return self.order_list.remove(order)
        else:
            assert False, "Order not found"

    def update_price(self, price: KLine):
        for order in self.order_list:
            order.update_price(price)

        if self.position is not None:
            close, unrelized_pnl = self.position.update_price(price)
            DATALOG.add_position(self.position.stats())
            if close:
                self.balance += self.position.balance()
                self.position = None
