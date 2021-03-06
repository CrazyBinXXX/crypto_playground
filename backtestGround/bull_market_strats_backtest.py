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
    data, extended_data = get_data('BTCUSDT', '2020-01-01', '2020-12-31', '15m', True, 'code_bull_prepared', CodeBullStrategy.extend_market)
    # extended_data = extended_data.iloc[-34200:-100]
    strat_bull = CodeBullStrategy(leverage=3)
    strat_long_short = MALongShortStrategy(leverage=1)

    strat_list = [strat_bull, strat_long_short]

    steps = 4 * 24 * 30 * 12 * 1 - 100
    s = Simulator(extended_data, strat_list)
    norm_price, hist_asset, norm_repot, hist_report = s.backtest(num_timestamps=steps)

    norm_repot.pretty_print()
    for report in hist_report:
        report.pretty_print()

    for strategy in strat_list:
        strategy.account.pretty_print()

    Simulator.plot_chart(norm_price, hist_asset[0], plt)
    plt.plot(hist_asset[1], 'b')

    plt.rcParams["figure.figsize"] = (30, 20)
    plt.show()

