"""
This module is to return market data for clients during backtesting.
"""
import pandas as pd
import numpy as np
from constants import *


class SimulationEndException(Exception):
    pass


class SimuMarket:
    """
    This is the class to simulate the market in backtests.
    """

    def __init__(self):
        self.df_data = None
        self.data_shape = None
        self.iter_idx = 0

    def reset_idx(self):
        self.iter_idx = 0

    def load_data(self, data_path):
        """
        Load data to the object.
        :param data_path:
        """
        self.df_data = pd.read_csv(data_path, index_col=0)
        self.data_shape = self.df_data.shape
        self.iter_idx = 0
        self.add_MA()

    def load_df(self, df: pd.DataFrame):
        """
        Load df to the object.
        :param df:
        """
        self.df_data = df
        self.data_shape = self.df_data.shape
        self.iter_idx = 0

    def add_MA(self, added_MA=None):
        if added_MA is None:
            added_MA = [5, 10, 20, 50, 100, 200]
        for ma in added_MA:
            self.df_data['{}MA_C'.format(ma)] = self.df_data['c'].rolling(window=ma).mean()
        self.np_data = np.array(self.df_data)
        self.data_shape = self.df_data.shape

    def add_bollings(self):
        self.df_data['ohlc'] = self.df_data.apply(lambda x: (x['o'] + x['h'] + x['l'] + x['c']) / 4, axis=1)
        self.df_data['bolling_m'] = self.df_data['ohlc'].rolling(20).apply(lambda x: x.mean())
        self.df_data['bolling_1u'] = self.df_data['ohlc'].rolling(20).apply(lambda x: x.mean() + x.std())
        self.df_data['bolling_2u'] = self.df_data['ohlc'].rolling(20).apply(lambda x: x.mean() + 2 * x.std())
        self.df_data['bolling_1l'] = self.df_data['ohlc'].rolling(20).apply(lambda x: x.mean() - x.std())
        self.df_data['bolling_2l'] = self.df_data['ohlc'].rolling(20).apply(lambda x: x.mean() - 2 * x.std())

        # Signals
        self.df_data['short_signal'] = self.df_data.apply(lambda x: x['o'] > x['bolling_1l'] > x['l'], axis=1)
        self.df_data['stop_loss_signal'] = self.df_data.apply(lambda x: x['o'] < x['bolling_1u'] and x['c'] > x['bolling_1u'], axis=1)
        self.df_data['touch_bottom'] = self.df_data.apply(lambda x: x['o'] > x['bolling_2l'] and x['l'] < x['bolling_2l'], axis=1)
        self.df_data['stop_profit_signal'] = self.df_data.apply(lambda x: x['o'] < x['bolling_1l'] and x['h'] > x['bolling_1l'], axis=1)

    def get_symbol_price_array(self):
        return np.array(self.df_data['c'])

    def get_cur_date(self):
        return self.df_data.iloc[min(self.iter_idx, self.df_data.shape[0] - 1)].name

    def get_cur_data(self):
        return self.df_data.iloc[min(self.iter_idx, self.df_data.shape[0] - 1)]

    def get_cur_price(self, symbol):
        return self.df_data.iloc[min(self.iter_idx, self.df_data.shape[0] - 1)]

    def get_next_data(self):
        """
        Get data of next timestamp.

        Important Data: 'o', 'h', 'l', 'c', 'v', 'num_trades', 'taker_base_val', 'taker_quote_val'
        """
        if self.iter_idx >= self.data_shape[0]:
            raise SimulationEndException('The simulation should end now')
        ret = self.df_data.iloc[self.iter_idx]
        self.iter_idx += 1
        return ret


if __name__ == "__main__":
    # print("I love mom")
    # exit()
    sm = SimuMarket()
    data_path = ROOT_PATH + "/dataHouse/data/ETHUSDT_2021-09-01-2021-09-30_1m.csv"
    sm.load_data(data_path)
    print(sm.get_cur_price('ETH'))