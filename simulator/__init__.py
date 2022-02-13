"""Object to run the simulate process and record stats"""
import random

import numpy as np

from scipy.stats import gaussian_kde
from constants import ROOT_PATH, SIMULATION_END
from simu_market import SimuMarket, SimulationEndException
from simulator.simu_report import SimuReport
from strategies import BaseStrategy
from strategies.bolling_strategy import BollingStrategy
from strategies.ma_strategy import MAStrategy
import matplotlib.pyplot as plt
import pandas as pd

from strategies.svm_strategy import SVMStrategy


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
        norm_sr, hist_sr, hedge_sr = pd.DataFrame(columns=['ROI', 'Corr', 'Volatility', 'Sharp Ratio', 'Max Dropdown']),\
                                     pd.DataFrame(columns=['ROI', 'Corr', 'Volatility', 'Sharp Ratio', 'Max Dropdown']),\
                                     pd.DataFrame(columns=['ROI', 'Corr', 'Volatility', 'Sharp Ratio', 'Max Dropdown'])
        for i in range(n):
            norm_price, hist_asset, hedge_price, norm_report, hist_report, hedge_report = self.backtest()
            norm_sr = norm_sr.append(norm_report.to_df(), ignore_index=True)
            hist_sr = hist_sr.append(hist_report.to_df(), ignore_index=True)
            hedge_sr = hedge_sr.append(hedge_report.to_df(), ignore_index=True)
        return norm_sr, hist_sr, hedge_sr

    def backtest(self, init_cash=10000, init_positions=None):
        if init_positions is None:
            init_positions = {}
        self.reset()
        self.strategy.account.set_init_cash(init_cash)
        self.strategy.account.init_positions = init_positions
        self.strategy.account.positions = init_positions
        self.strategy.account.mortgage = 0
        hist_asset = []
        try:
            i = 0
            while True:
                # if i % 1000 == 0:
                #     print('STEP: {}'.format(i))
                i += 1
                end = self.strategy.step()
                hist_asset.append(self.strategy.account.get_total_asset())
        except SimulationEndException as e:
            print(e)
        print("BACKTEST END")
        print(self.strategy.trade_num)
        print(self.strategy.account.trading_fee)
        eth_price = self.strategy.market.get_symbol_price_array()
        norm_price = eth_price / eth_price[0] * 10000
        hedge_price = (hist_asset + (20000 - norm_price)) / 2
        SimuReport(norm_price).pretty_print("Standard")
        SimuReport(hist_asset).pretty_print("Strat")
        # SimuReport(hedge_price).pretty_print("Hedge")
        return norm_price, hist_asset, hedge_price, \
               SimuReport(norm_price), SimuReport(hist_asset), SimuReport(hedge_price)

    @staticmethod
    def plot_histogram(data_arr, canvas):
        q25, q75 = np.percentile(data_arr, [25, 75])
        bin_width = 2 * (q75 - q25) * len(data_arr) ** (-1 / 3)
        bins = round((data_arr.max() - data_arr.min()) / bin_width)
        print("Freedman–Diaconis number of bins:", bins)

        canvas.hist(data_arr, density=True, bins=bins * 2, label="Data")
        mn, mx = -2, 2
        canvas.axis(xmin=mn, xmax=mx)
        kde_xs = np.linspace(mn, mx, 300)
        kde = gaussian_kde(data_arr)
        canvas.plot(kde_xs, kde.pdf(kde_xs), label="PDF")
        canvas.legend(loc="upper left")
        canvas.set_ylabel("Probability")
        canvas.set_xlabel("Data")

    @staticmethod
    def plot_chart(standard_arr, data_arr, canvas):
        canvas.plot(standard_arr, 'r')
        canvas.plot(data_arr, 'g')

if __name__ == "__main__":
    DATA_PATH = ROOT_PATH + "/dataHouse/ETHUSDT_2021-01-01-2021-12-31_15m.csv"
    data = pd.read_csv(DATA_PATH)
    strat = BollingStrategy()
    s = Simulator(data, strat)
    norm_price, hist_asset, hedge_price, norm_report, hist_report, hedge_report = s.backtest()
    Simulator.plot_chart(norm_price, hist_asset, plt)
    plt.show()
    exit()

    norm_reports, hist_reports, hedge_reports = s.heavy_tests(n=200)
    # figure, axis = plt.subplots(nrows=2, ncols=1)
    # Simulator.plot_histogram(norm_reports['Sharp Ratio'].values, axis[0])
    # Simulator.plot_histogram(hist_reports['Sharp Ratio'].values, axis[1])
    # Simulator.plot_histogram(hedge_reports['Sharp Ratio'].values, axis[2])
    rename_dict = {}
    for each in list(norm_reports.columns):
        rename_dict[each] = each + ' Standard'
    norm_reports = norm_reports.rename(index=str, columns=rename_dict)
    hist_reports.index = norm_reports.index
    final_reports = norm_reports.merge(hist_reports, left_index=True, right_index=True)
    final_reports = final_reports.reindex(sorted(final_reports.columns), axis=1)
    strat_name = 'bolling001'
    final_reports.to_csv("./simulationResults/{0}_{1}_{2}-{3}.csv".format(strat_name, 'ETH', '2021-01-01', '2021-12-31'))
    # plt.show()
