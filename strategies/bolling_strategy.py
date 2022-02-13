from account import Account
from simu_market import SimuMarket
from constants import *
from strategies import BaseStrategy


class BollingStrategy(BaseStrategy):
    def __init__(self):
        super().__init__()
        self.hold = False
        self.can_sell = False

    def load_market(self, market):
        super().load_market(market)
        print('Adding lines......')
        self.market.add_bollings()
        print('Adding finished')

    def reset(self):
        self.hold = False
        self.can_sell = False

    def buy_signal(self, new_data):
        return (not self.hold) and (new_data['short_signal'])

    def sell_signal(self, new_data):
        return self.hold and self.can_sell and (new_data['stop_profit_signal'])

    def step(self):
        new_data = self.market.get_next_data()
        print(self.account.cash, self.account.positions, self.account.mortgage)
        if self.hold and new_data['touch_bottom']:
            self.can_sell = True
        if self.buy_signal(new_data):
            self.account.short_all_at_price('ETH', new_data['bolling_m'])
            self.hold = True
            self.can_sell = False
        if self.sell_signal(new_data):
            self.account.close_all_at_price('ETH', new_data['bolling_1l'])
            self.hold = False
            self.can_sell = False
        return 0


if __name__ == "__main__":
    strat = BollingStrategy()
    sm = SimuMarket()
    data_path = ROOT_PATH + "/dataHouse/ETHUSDT_2021-09-01-2021-09-30_1m.csv"
    sm.load_data(data_path)
    strat.load_market(sm)
    for i in range(30):
        strat.step()
