import random
import os
import numpy as np
from constants import ROOT_PATH, SIMULATION_END
from simulator import Simulator
from strategies.code_bull_strategy import CodeBullStrategy
from strategies.ma_long_short_strategy import MALongShortStrategy
from strategies.ma_short_strategy import MAShortStrategy
from strategies.random_forest_strategy import RandomForestStrategy
from strategies.random_forest_hold_strategy import RandomForestHoldStrategy
import pandas as pd
from utils import get_data


if __name__ == "__main__":
    print('ML backtest started:')
    intervals1 = ['2017-07-10', '2022-07-10']
    intervals2 = ['2021-06-23', '2022-06-23']
    # data, extended_data = get_data('BTCUSDT', intervals1[0], intervals1[1], '15m', True, 'learning_prepared_v1.1_predicted', MAShortStrategy.extend_market)
    extended_data = pd.read_csv('/opt/project/dataHouse/data/preparedData/BTCUSDT_2017-07-10-2022-07-10_15m_hold_prepared_v0.1_predicted.csv')

    extended_data = extended_data.iloc[-1 * 12 * 30 * 24 * 4 // 1:]
    strat_rf = RandomForestHoldStrategy(fast=True)

    strat_list = [strat_rf]

    steps = 1 * 12 * 30 * 24 * 4 // 1 - 1
    s = Simulator(extended_data, strat_list)
    norm_price, hist_asset, norm_report, hist_report = s.backtest(num_timestamps=steps)

    norm_report.pretty_print()
    print('STRAT REPORT:')
    for report in hist_report:
        report.pretty_print()

    for strategy in strat_list:
        strategy.account.pretty_print()

    # Simulator.plot_chart(norm_price, hist_asset[0], plt)
    #
    # plt.rcParams["figure.figsize"] = (30, 20)
    # plt.show()

