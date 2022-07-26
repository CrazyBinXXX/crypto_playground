import pandas as pd

from common.KLine import KLine
from markets.Fee import Fee


class SimuMarket:
    def __init__(self):
        self.data = None
        self.index = 0
        self.call_back_list = []
        self.account = None

    def add_account(self, account):
        self.account = account

    def config(self, config):
        self.fee = Fee(config.MAKER_FEE, config.TAKER_FEE)

    def load_data_csv(self, path):
        self.data = pd.read_csv(path)

    def add_callback(self, func):
        self.call_back_list.append(func)

    def get_price(self) -> KLine:
        row = self.data.iloc[self.index, :]
        price = KLine(row['l'], row['h'], row['o'], row['c'], row['close_time'])
        price.set_data(row)
        return price

    def step(self):
        if self.data is None:
            raise Exception("Data not load")

        price = self.get_price()

        self.account.update_price(price)

        for callback in self.call_back_list:
            callback(price)

        self.index += 1

    def run(self):
        for _ in range(self.index, len(self.data)):
            self.step()
