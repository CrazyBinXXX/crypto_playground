"""Object to run the simulate process and record stats"""
import random

import numpy as np

from constants import ROOT_PATH, SIMULATION_END
from simu_market import SimuMarket, SimulationEndException
from simulator.simu_report import SimuReport
from strategies import BaseStrategy
from strategies.ma_strategy import MAStrategy
import matplotlib.pyplot as plt
import pandas as pd


class Simulator:
    def __init__(self, data, strategy: BaseStrategy, n=10000):
        market = SimuMarket()
        self.data = data
        market.load_df(self.random_slice(n))
        self.strategy = strategy
        self.strategy.load_market(market)

    def random_slice(self, n):
        rand_start = random.randint(0, self.data.shape[0] - n - 1)
        data = self.data.iloc[rand_start: rand_start + n]
        return data

    def step(self):
        self.strategy.step()

    def score(self, data_arr):
        pass

    def backtest(self, init_cash=10000, init_positions={}):
        self.strategy.account.set_cash(init_cash)
        self.strategy.account.positions = init_positions
        hist_asset = []
        try:
            i = 0
            while True:
                if i % 1000 == 0:
                    print('STEP: {}'.format(i))
                i += 1
                end = self.strategy.step()
                hist_asset.append(self.strategy.account.get_total_asset())
        except SimulationEndException as e:
            print(e)
        print("BACKTEST END")
        eth_price = self.strategy.market.get_symbol_price_array()
        norm_price = eth_price / eth_price[0] * 10000
        SimuReport(hist_asset).pretty_print()
        SimuReport(norm_price).pretty_print()
        return hist_asset

if __name__ == "__main__":
    DATA_PATH = ROOT_PATH + "/dataHouse/ETHUSDT_2021-09-01-2021-09-30_1m.csv"
    data = pd.read_csv(DATA_PATH)
    strat = MAStrategy()
    s = Simulator(data, strat)
    hist_asset = s.backtest()
    plt.plot(hist_asset, 'g', label='Strat')
    eth_price = s.strategy.market.get_symbol_price_array()
    norm_price = eth_price / eth_price[0] * 10000
    plt.plot(norm_price, 'r', label='Underlying')
    plt.show()
