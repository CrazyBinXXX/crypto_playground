from account import Account
from simu_market import SimuMarket
from constants import *
from strategies import BaseStrategy


class MAStrategy(BaseStrategy):
    def __init__(self):
        super().__init__()
        self.last_data = None
        self.longing = False
        self.shorting = False
        self.holding_limit = 96
        self.holding_days = -1

    def reset(self):
        self.last_data = None
        self.longing = False
        self.shorting = False
        self.holding_days = -1

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
        if self.holding_days > -1:
            self.holding_days += 1
        # Take Action
        if new_data['trend_bull']:
            if not self.longing:
                self.account.long_underlying('BTC')
                self.longing = True
                self.holding_days = 0
        elif new_data['trend_bear'] and self.holding_days >= self.holding_limit:
            if self.longing:
                self.account.close_long_position('BTC')
                self.longing = False
                self.holding_days = -1
        return 0


if __name__ == "__main__":
    strat = MAStrategy()
    sm = SimuMarket()
    data_path = ROOT_PATH + "/dataHouse/ETHUSDT_2021-06-01-2021-12-31_1m.csv"
    sm.load_data(data_path)
    strat.load_market(sm)
    for i in range(10):
        strat.step()
