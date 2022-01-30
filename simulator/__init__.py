"""Object to run the simulate process and record stats"""
import random

import numpy as np

from constants import ROOT_PATH, SIMULATION_END
from simu_market import SimuMarket, SimulationEndException
from strategies import BaseStrategy
from strategies.ma_strategy import MAStrategy
import matplotlib.pyplot as plt
import pandas as pd


class Simulator:
    def __init__(self, data, strategy: BaseStrategy):
        market = SimuMarket()
        market.load_df(data)
        self.strategy = strategy
        self.strategy.load_market(market)

    def step(self):
        self.strategy.step()

    @staticmethod
    def print_insight(data_arr):
        print(data_arr[0], data_arr[-1])
        print("Return: {}%".format((data_arr[-1] / data_arr[0] * 100 - 100).round(4)))
        print("Volatility: {}, {}%".format(np.std(data_arr), (np.std(data_arr) / np.mean(data_arr) * 100).round(4)))

    def backtest(self, init_cash=10000, init_positions={}):
        self.strategy.account.set_cash(init_cash)
        self.strategy.account.positions = init_positions
        hist_asset = []
        hist_asset.append(self.strategy.account.get_total_asset())
        try:
            i = 0
            while True:
                print('STEP: {}'.format(i))
                i += 1
                end = self.strategy.step()
                hist_asset.append(self.strategy.account.get_total_asset())
        except SimulationEndException as e:
            print(e)
        print("BACKTEST END")
        print("MY SCOREBOARD: ")
        self.print_insight(hist_asset)
        eth_price = self.strategy.market.get_symbol_price_array()
        norm_price = eth_price / eth_price[0] * 10000
        print("STD SCOREBOARD: ")
        self.print_insight(norm_price)
        return hist_asset


if __name__ == "__main__":
    DATA_PATH = ROOT_PATH + "/dataHouse/ETHUSDT_2021-09-01-2021-09-30_1m.csv"
    data = pd.read_csv(DATA_PATH)
    rand_start = random.randint(0, data.shape[0] - 10001)
    data = data.iloc[rand_start : rand_start + 10000]
    strat = MAStrategy()
    s = Simulator(data, strat)
    hist_asset = s.backtest()
    plt.plot(hist_asset, 'g', label='Strat')
    eth_price = s.strategy.market.get_symbol_price_array()
    norm_price = eth_price / eth_price[0] * 10000
    plt.plot(norm_price, 'r', label='Underlying')
    plt.show()
