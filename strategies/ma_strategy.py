from account import Account
from simu_market import SimuMarket
from constants import *
from strategies import BaseStrategy


class MAStrategy(BaseStrategy):
    def __init__(self):
        super().__init__()
        self.last_data = None
        self.hold_days = -1

    def reset(self):
        self.last_data = None
        self.hold_days = -1

    @staticmethod
    def buy_signal(last_data, new_data):
        if last_data is None:
            return False
        if not last_data['10MA_C']:
            return False
        return last_data['5MA_C'] < last_data['10MA_C'] and new_data['5MA_C'] > new_data['10MA_C']

    @staticmethod
    def sell_signal(last_data, new_data):
        if last_data is None:
            return False
        if not last_data['10MA_C']:
            return False
        return last_data['5MA_C'] > last_data['10MA_C'] and new_data['5MA_C'] < new_data['10MA_C']

    def step(self):
        new_data = self.market.get_next_data()
        if self.hold_days >= 0:
            self.hold_days += 1
        if self.buy_signal(self.last_data, new_data):
            self.account.buy_all('ETH')
            self.hold_days = 0
        if self.hold_days >= 10:
            self.account.sell_all('ETH')
            self.hold_days = -1
        self.last_data = new_data
        return 0


if __name__ == "__main__":
    strat = MAStrategy()
    sm = SimuMarket()
    data_path = ROOT_PATH + "/dataHouse/ETHUSDT_2021-06-01-2021-12-31_1m.csv"
    sm.load_data(data_path)
    strat.load_market(sm)
    for i in range(10):
        strat.step()
