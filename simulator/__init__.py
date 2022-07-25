"""Object to run the simulate process and record stats"""
import random

import numpy as np

from scipy.stats import gaussian_kde

from backtestGround.utils import tangency_portfolio
from constants import ROOT_PATH, SIMULATION_END
from simu_market import SimuMarket, SimulationEndException
from simulator.simu_report import SimuReport
from strategies import BaseStrategy
from strategies.bolling_king_strategy import BollingKingStrategy
from strategies.bolling_strategy import BollingStrategy
from strategies.bull_strategy import BullStrategy
from strategies.code_bull_strategy import CodeBullStrategy
from strategies.ma_long_short_strategy import MALongShortStrategy
from strategies.ma_strategy import MAStrategy
from strategies.ma_short_strategy import MAShortStrategy
import matplotlib.pyplot as plt
import pandas as pd
import copy

from strategies.svm_strategy import SVMStrategy


class Simulator:
    def __init__(self, data_set, strategy_list, start_idx=0):
        self.data_set = data_set
        self.strategy_list = strategy_list
        self.init_cash = 10000
        self.start_idx = start_idx

    def reset(self, time_window=10000):
        market = SimuMarket()
        market.load_df(self.random_slice(time_window))
        market.set_idx(self.start_idx)
        for strategy in self.strategy_list:
            strategy.load_market(copy.deepcopy(market), self.init_cash)

    def random_slice(self, time_window):
        rand_start = random.randint(0, self.data_set.shape[0] - time_window - 1)
        print(self.data_set.head())
        data = self.data_set.iloc[int(rand_start): int(rand_start + time_window)]
        print("random slice: ", rand_start, rand_start + time_window)
        return data

    def step(self):
        for strategy in self.strategy_list:
            strategy.step()

    def score(self, data_arr):
        pass

    # def heavy_tests(self, n=100):
    #     norm_sr, hist_sr, hedge_sr = pd.DataFrame(columns=['ROI', 'Corr', 'Volatility', 'Sharp Ratio', 'Max Dropdown']),\
    #                                  pd.DataFrame(columns=['ROI', 'Corr', 'Volatility', 'Sharp Ratio', 'Max Dropdown']),\
    #                                  pd.DataFrame(columns=['ROI', 'Corr', 'Volatility', 'Sharp Ratio', 'Max Dropdown'])
    #     for i in range(n):
    #         norm_price, hist_asset, hedge_price, norm_report, hist_report, hedge_report = self.backtest()
    #         norm_sr = norm_sr.append(norm_report.to_df(), ignore_index=True)
    #         hist_sr = hist_sr.append(hist_report.to_df(), ignore_index=True)
    #         hedge_sr = hedge_sr.append(hedge_report.to_df(), ignore_index=True)
    #     return norm_sr, hist_sr, hedge_sr

    def backtest(self, init_cash=10000, init_positions=None, num_timestamps=10000):
        self.init_cash = init_cash
        if init_positions is None:
            init_positions = {}
        self.reset(time_window=num_timestamps)
        history_asset = [[] for i in range (len(self.strategy_list))]
        try:
            i = 0
            while True:
                if i % 1000 == 0:
                    print('STEP: {}'.format(i))
                i += 1
                self.step()
                for j, strategy in enumerate(self.strategy_list):
                    history_asset[j].append(strategy.account.get_total_asset())
        except SimulationEndException as e:
            print(e)
        print("BACKTEST END")
        underlying_price = self.strategy_list[0].market.get_symbol_price_array()
        normal_price = underlying_price / underlying_price[0] * init_cash
        return normal_price, history_asset, SimuReport(normal_price), [SimuReport(e) for e in history_asset]

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



if __name__ == "__main__xxx":
    DATA_PATH = ROOT_PATH + "/dataHouse/data/cryptoPrices/BTCUSDT_2021-06-23-2022-06-23_1m.csv"
    PREPARED_DATA_PATH = ROOT_PATH + "/dataHouse/data/preparedData/BTCUSDT_2021-06-23-2022-06-23_1m.csv"
    data = pd.read_csv(DATA_PATH, index_col=0)
    try:
        extended_data = pd.read_csv(PREPARED_DATA_PATH, index_col=0)
    except FileNotFoundError:
        extended_data = BollingKingStrategy.extend_market(data)
        extended_data.to_csv(PREPARED_DATA_PATH)
        extended_data = pd.read_csv(PREPARED_DATA_PATH, index_col=0)
    extended_data = extended_data.iloc[-100100:-100]
    strat = BollingKingStrategy()
    # strat = BullStrategy()
    steps = 50000
    s = Simulator(extended_data, [strat], n=steps)
    norm_price, hist_asset, norm_repot, hist_report = s.backtest(num_timestamps=steps)
    norm_repot.pretty_print()
    hist_report[0].pretty_print()
    w = tangency_portfolio(norm_price, hist_asset[0])
    w = np.array([0, 3, -2])
    print('The tangency weight vector w is:', w)
    tangency_price = w[0] * norm_price + w[1] * np.array(hist_asset[0]) + w[2] * 10000
    tangency_report = SimuReport(tangency_price)
    tangency_report.pretty_print()
    strat.account.pretty_print()
    Simulator.plot_chart(norm_price, hist_asset[0], plt)
    plt.plot(tangency_price, 'blue')
    plt.rcParams["figure.figsize"] = (30, 20)
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

if __name__ == "__main__":
    DATA_PATH = ROOT_PATH + "/dataHouse/data/cryptoPrices/BTCUSDT_2020-01-01-2020-12-31_15m.csv"
    PREPARED_DATA_PATH = ROOT_PATH + "/dataHouse/data/preparedData/BTCUSDT_2020-01-01-2020-12-31_15m_mashort_prepared.csv"
    data = pd.read_csv(DATA_PATH, index_col=0)
    try:
        extended_data = pd.read_csv(PREPARED_DATA_PATH, index_col=0)
    except FileNotFoundError:
        extended_data = CodeBullStrategy.extend_market(data)
        extended_data.to_csv(PREPARED_DATA_PATH)
        extended_data = pd.read_csv(PREPARED_DATA_PATH, index_col=0)
    # extended_data = extended_data.iloc[-34200:-100]
    strat = MAShortStrategy()
    strat_long_short = MALongShortStrategy()
    steps = 4 * 24 * 30 * 12 * 1 - 100
    s = Simulator(extended_data, [strat, strat_long_short])
    norm_price, hist_asset, norm_repot, hist_report = s.backtest(num_timestamps=steps)
    norm_repot.pretty_print()
    hist_report[0].pretty_print()

    hist_report[1].pretty_print()
    strat.account.pretty_print()

    strat_long_short.account.pretty_print()
    Simulator.plot_chart(norm_price, hist_asset[0], plt)

    plt.plot(hist_asset[1], 'b')

    plt.rcParams["figure.figsize"] = (30, 20)
    plt.show()

