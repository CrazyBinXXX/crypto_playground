from markets.FuturesOrder import *


class FuturesAccount:

    def __init__(self, balance, market):
        self.balance = balance
        self.order_list = []
        self.market = market

    def open_order(self, side: Side, margin, price, leverage, type):
        if self.balance < margin:
            raise Exception("Insufficient balance")

        order = FuturesOrder(self)
        order.open(side, price, margin, leverage, type)
        self.balance -= order.margin
        self.order_list.append(order)
        self.market.add_order(order)

        return order

    def close_order(self, order: FuturesOrder):
        if not order.is_open:
            raise Exception("Order already closed")
        if order.account != self:
            raise Exception("Order doesn't belong")

        try:
            idx = self.order_list.index(order)
            self.order_list.remove(idx)

            self.balance += order.close()
            self.market.close_order(order)
        except ValueError as e:
            raise Exception(f"Order not found, {e}. This indicates bug.")

    def order_list(self):
        return self.order_list
