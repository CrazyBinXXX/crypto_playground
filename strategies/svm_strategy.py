from account import Account
from simu_market import SimuMarket
from constants import *
import pandas as pd
from strategies import BaseStrategy
from joblib import dump, load
from constants import ROOT_PATH

class SVMStrategy(BaseStrategy):
    def __init__(self):
        super().__init__()
        self.last_data = None
        self.hold_days = -1
        self.clf_model = load(ROOT_PATH + '/modelHouse/svm_0.joblib')
        self.n_list = [1, 5, 7, 14, 28]
        self.metrics_list = [str(each) + 'diff' for each in self.n_list]
        self.buy_signals = []

    def reset(self):
        self.last_data = None
        self.hold_days = -1

    def load_market(self, market):
        super().load_market(market)
        self.add_metrics()

    def add_metrics(self):
        for i in self.n_list:
            self.market.df_data['{}diff'.format(i)] = self.market.df_data['c'].pct_change(i) * 100

    def buy_signal(self, new_data):
        valued_data = new_data[self.metrics_list]
        if valued_data.isnull().any():
            return False
        temp_data = valued_data.to_dict()
        for k, v in temp_data.items():
            temp_data[k] = [v]
        valued_data = pd.DataFrame(data=temp_data)
        prediction = self.clf_model.predict(valued_data)
        self.buy_signals.append(prediction[0])
        return prediction[0] == 1

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
        if self.hold_days >= 14:
            self.account.sell_all()
            self.hold_days = -1
        elif self.hold_days == -1 and self.buy_signal(new_data):
            self.account.buy_all()
            self.hold_days = 0
        return 0


if __name__ == "__main__":
    strat = SVMStrategy()
    sm = SimuMarket()
    data_path = ROOT_PATH + "/dataHouse/ETHUSDT_2021-06-01-2021-12-31_1m.csv"
    sm.load_data(data_path)
    strat.load_market(sm)
    for i in range(30):
        strat.step()
