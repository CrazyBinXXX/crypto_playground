import pandas as pd
from fee import Fee

class SimuMarket:
    def __init__(self):
        self.data = None
        self.index = 0
        self.call_back_list = []
        self.order_list = []

    def config(self, config):
        self.fee = Fee(config.MAKER_FEE, config.TAKER_FEE)

    def load_data_csv(self, path):
        self.data = pd.read_csv(path)

    def add_callback(self, func):
        self.call_back_list.append(func)

    def get_price(self):
        pass # todo unimplemented

        return "PRICE"

    def step(self):
        if self.data is None:
            raise Exception("Data not load")

        price = self.get_price()

        for order in self.order_list:
            order.calc_unrelized_pnl(price)
            if not order.is_open:
                order.account.close_order(order)
            self.add_stats(order)

        for callback in self.call_back_list:
            callback(data)

        self.index += 1

    def close_order(self, order):
        try:
            index = self.order_list.index(order)
            self.order_list.pop(index)
        except ValueError as e:
            raise Exception(f"Order not found, {e}. This indicates bug.")

    # markets stats. Todo, add account stats
    def add_stats(self, order):
        self.order_stats = pd.append() # todo append stats here

    def run(self):
        for _ in range(self.index, len(self.data)):
            self.step()
