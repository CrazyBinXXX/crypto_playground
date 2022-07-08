import random

import numpy as np
from constants import ROOT_PATH, SIMULATION_END
from simulator import Simulator
from strategies.code_bull_strategy import CodeBullStrategy
from strategies.ma_long_short_strategy import MALongShortStrategy
from strategies.ma_short_strategy import MAShortStrategy
import matplotlib.pyplot as plt
import pandas as pd
from utils import get_data


if __name__ == "__main__":
    data, extended_data = get_data('BTCUSDT', '2018-01-01', '2020-01-01', '15m', True, 'mashort_prepared', MAShortStrategy.extend_market)
    # extended_data = extended_data.iloc[-34200:-100]
    strat = MAShortStrategy()
    strat_long_short = MALongShortStrategy()

    strat_list = [strat, strat_long_short]

    steps = 4 * 24 * 30 * 12 * 2 - 100
    s = Simulator(extended_data, strat_list)
    norm_price, hist_asset, norm_repot, hist_report = s.backtest(num_timestamps=steps)

    norm_repot.pretty_print()
    for report in hist_report:
        report.pretty_print()

    for strat in strat_list:
        strat.account.pretty_print()
        strat_long_short.account.pretty_print()

    Simulator.plot_chart(norm_price, hist_asset[0], plt)
    plt.plot(hist_asset[1], 'b')

    plt.rcParams["figure.figsize"] = (30, 20)
    plt.show()

