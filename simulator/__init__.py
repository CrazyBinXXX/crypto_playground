"""Object to run the simulate process and record stats"""

from constants import ROOT_PATH
from simu_market import SimuMarket
from strategies import BaseStrategy
from strategies.ma_strategy import MAStrategy


class Simulator:
    def __init__(self, data_path: str, strategy: BaseStrategy):
        market = SimuMarket()
        market.load_data(data_path)
        self.strategy = strategy
        self.strategy.load_market(market)

    def step(self):
        self.strategy.step()

    def backTest(self):
        while True:
            self.strategy.step()

if __name__ == "__main__":
    DATA_PATH = ROOT_PATH + "/dataHouse/ETHUSDT_2021-09-01-2021-09-30_1m.csv"
    strat = MAStrategy()
    s = Simulator(DATA_PATH, strat)
