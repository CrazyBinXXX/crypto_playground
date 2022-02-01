"""Object to run the simulate process and record stats"""
import random

import numpy as np

from scipy.stats import gaussian_kde
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

    def reset(self, n=10000):
        market = SimuMarket()
        market.load_df(self.random_slice(n))
        self.strategy.load_market(market)

    def random_slice(self, n):
        rand_start = random.randint(0, self.data.shape[0] - n - 1)
        data = self.data.iloc[rand_start: rand_start + n]
        return data

    def step(self):
        self.strategy.step()

    def score(self, data_arr):
        pass

    def heavy_tests(self, n=100):
        norm_sr, hist_sr, hedge_sr = [], [], []
        for i in range(n):
            norm_price, hist_asset, hedge_price, norm_report, hist_report, hedge_report = self.backtest()
            norm_sr.append(norm_report.sharp_ratio)
            hist_sr.append(hist_report.sharp_ratio)
            hedge_sr.append(hedge_report.sharp_ratio)
        return norm_sr, hist_sr, hedge_sr

    def backtest(self, init_cash=10000, init_positions={}):
        self.reset()
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
        hedge_price = (hist_asset + (20000 - norm_price)) / 2
        SimuReport(norm_price).pretty_print("Standard")
        SimuReport(hist_asset).pretty_print("Strat")
        SimuReport(hedge_price).pretty_print("Hedge")
        return norm_price, hist_asset, hedge_price, \
               SimuReport(norm_price), SimuReport(hist_asset), SimuReport(hedge_price)


if __name__ == "__main__":
    DATA_PATH = ROOT_PATH + "/dataHouse/ETHUSDT_2021-09-01-2021-09-30_1m.csv"
    data = pd.read_csv(DATA_PATH)
    strat = MAStrategy()
    s = Simulator(data, strat)

    norm_sr, hist_sr, hedge_sr = s.heavy_tests(300)
    hedge_sr = np.array(hedge_sr)

    q25, q75 = np.percentile(hedge_sr, [25, 75])
    bin_width = 2 * (q75 - q25) * len(hedge_sr) ** (-1 / 3)
    bins = round((hedge_sr.max() - hedge_sr.min()) / bin_width)
    print("Freedman–Diaconis number of bins:", bins)

    plt.hist(hedge_sr, density=True, bins=bins * 2, label="Data")
    mn, mx = plt.xlim()
    plt.xlim(mn, mx)
    kde_xs = np.linspace(mn, mx, 300)
    kde = gaussian_kde(hedge_sr)
    plt.plot(kde_xs, kde.pdf(kde_xs), label="PDF")
    plt.legend(loc="upper left")
    plt.ylabel("Probability")
    plt.xlabel("Data")
    plt.title("Histogram");
    plt.show()