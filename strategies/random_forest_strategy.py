from account import Account
from simu_market import SimuMarket
from constants import *
from strategies import BaseStrategy
import pandas as pd
import tensorflow as tf
from constants import ROOT_PATH
import _pickle as cPickle
import tensorflow_decision_forests as tfdf
from numpy_ext import rolling_apply
import numpy as np
import math


class RandomForestStrategy(BaseStrategy):
    def __init__(self, leverage=1, complex=False):
        super().__init__()
        self.last_data = None
        self.longing = False
        self.shorting = False
        self.holding_limit = 96
        self.holding_days = -1
        self.entry_price = -1
        self.entry_asset = -1
        self.started = False
        self.frozen = 0
        self.max_holding = 9999999999999999
        self.high_volume_factor = 9
        self.leverage = leverage
        long_model_path = "../modelHouse/rf_long_model_v0.6"
        self.rf_long_model = tf.keras.models.load_model(long_model_path)
        short_model_path = "../modelHouse/rf_short_model_v0.6"
        self.rf_short_model = tf.keras.models.load_model(short_model_path)
        self.complex = complex

    def load_market(self, market, init_cash):
        super().load_market(market, init_cash)

    @staticmethod
    def extend_market(market_data):
        market_data.loc[:, 'o'] = market_data['o'].astype(float)
        market_data.loc[:, 'h'] = market_data['h'].astype(float)
        market_data.loc[:, 'l'] = market_data['l'].astype(float)
        market_data.loc[:, 'c'] = market_data['c'].astype(float)
        market_data.loc[:, 'v'] = market_data['v'].astype(float)
        market_data.loc[:, 'ohlc'] = market_data.apply(lambda x: (x['o'] + x['h'] + x['l'] + x['c']) / 4, axis=1)
        market_data.loc[:, 'bolling_m'] = market_data['c'].rolling(200).apply(lambda x: x.mean())
        market_data.loc[:, 'bolling_2u'] = market_data['c'].rolling(200).apply(lambda x: x.mean() + 2 * x.std())
        market_data.loc[:, 'bolling_2l'] = market_data['c'].rolling(200).apply(lambda x: x.mean() - 2 * x.std())
        market_data.loc[:, 'volatility'] = market_data['bolling_2u'] - market_data['bolling_2l']
        market_data.loc[:, 'base_vol'] = market_data['volatility'].rolling(2000).mean()
        market_data.loc[:, 'base_vol'] = market_data['base_vol'].fillna(method='bfill')
        market_data.loc[:, 'vol_too_high'] = market_data.apply(lambda x: x['volatility'] > 1.5 * x['base_vol'], axis=1)
        market_data.loc[:, 'trendEMA'] = market_data['c'].ewm(span=1500, adjust=False).mean()
        market_data.loc[:, 'trend_bull'] = market_data.apply(lambda x: x['c'] > x['trendEMA'], axis=1)
        market_data.loc[:, 'trend_bear'] = market_data.apply(lambda x: x['c'] < x['trendEMA'], axis=1)
        market_data['TR'] = market_data['h'] - market_data['l']
        market_data['MATR'] = market_data['TR'].rolling(14).apply(lambda x: x.mean())
        market_data['EATR'] = market_data['TR'].ewm(span=14, adjust=False).mean()
        market_data.loc[:, '200_ma_volume'] = market_data['v'].rolling(200).apply(lambda x: x.mean())
        smaLength = 20
        emaLength = 21
        market_data.loc[:, 'sma'] = market_data['c'].rolling(smaLength).apply(lambda x: x.mean())
        market_data.loc[:, 'ema'] = market_data['c'].ewm(span=emaLength, adjust=True).mean()
        return market_data.iloc[500:]

    @staticmethod
    def more_alpha(df):
        # Alpha 6, ov against
        df['alpha_6'] = -1 * rolling_apply(lambda x, y: np.corrcoef([x, y])[0, 1], 10, df.o.values, df.v.values)
        # Alpha 12, cv momentem
        df['1_v_log_ret'] = df['v'].rolling(2).apply(
            lambda x: math.log(x.iloc[1] / x.iloc[0]) if x.iloc[1] / x.iloc[0] > 0 else 0)
        df['1_c_log_ret'] = df['c'].rolling(2).apply(lambda x: math.log(x.iloc[1] / x.iloc[0]))
        df['alpha_12'] = df.apply(lambda x: (1 if x['1_v_log_ret'] > 0 else -1) * -1 * x['1_c_log_ret'], axis=1)
        return df.iloc[20:]

    def reset(self):
        self.last_data = None
        self.longing = False
        self.shorting = False
        self.holding_days = -1

    def exit_reset(self):
        self.shorting = False
        self.longing = False
        self.holding_days = -1
        self.entry_price = -1
        self.entry_asset = -1

    def step(self):
        new_data = self.market.get_next_data()
        if self.holding_days > -1:
            self.holding_days += 1
        # Take Action
        input_dict = {
            'vol_too_high': [new_data['vol_too_high']],
            'trend_bull': [new_data['trend_bull']],
            'trend_bear': [new_data['trend_bear']],
            'bolling_bull': [new_data['bolling_bull']],
            'bolling_bear': [new_data['bolling_bear']],
            'o_relative': [new_data['o_relative']],
            'h_relative': [new_data['h_relative']],
            'l_relative': [new_data['l_relative']],
            'c_relative': [new_data['c_relative']],
            'v_relative': [new_data['v_relative']],
            '10_c_log_return': [new_data['10_c_log_return']],
            '30_c_log_return': [new_data['30_c_log_return']],
            '60_c_log_return': [new_data['60_c_log_return']],
            '10_c_bull': [new_data['60_c_log_return']],
            '30_c_bull': [new_data['30_c_bull']],
            '60_c_bull': [new_data['60_c_bull']],
            'long_signal': [new_data['long_signal']],
            'short_signal': [new_data['short_signal']],
            'alpha_6': [new_data['alpha_6']],
            'alpha_12': [new_data['alpha_12']],
        }
        input_dict = {}
        input_cols = ['vol_too_high', 'trend_bull', 'trend_bear', '10_c_log_return',
                      '30_c_log_return', '60_c_log_return', '10_c_bull', '30_c_bull',
                      '60_c_bull', 'bolling_bull', 'bolling_bear', 'o_relative', 'h_relative',
                      'l_relative', 'c_relative', 'v_relative', 'long_signal', 'short_signal',
                      'alpha_6', 'alpha_12']
        for col in input_cols:
            input_dict[col] = [new_data[col]]
        input_df = pd.DataFrame.from_dict(input_dict) * 1
        input_ds = tfdf.keras.pd_dataframe_to_tf_dataset(input_df)

        long_result = self.rf_long_model.predict(input_ds)[0][0]
        short_result = self.rf_short_model.predict(input_ds)[0][0]

        long_flag = long_result > 0.55
        short_flag = short_result > 0.55
        if long_flag and short_flag:
            long_flag = long_result > short_result
            short_flag = long_result <= short_result

        if self.shorting or self.longing:
            # Decide whether to exit
            take_profit = 0.10
            stop_loss = -0.05
            if self.shorting:
                take_profit_price = self.entry_price / (1 + take_profit)
                stop_loss_price = self.entry_price / (1 + stop_loss)
                take_profit_price_exec = self.entry_price / (1 + take_profit * self.leverage)
                stop_loss_price_exec = self.entry_price / (1 + stop_loss * self.leverage)
                # Take profit / Stop loss
                if new_data['h'] > stop_loss_price:
                    self.account.close_short_position('BTC', execution_price=stop_loss_price_exec)
                    self.exit_reset()
                    if self.complex:
                        self.leverage -= 0.1
                elif new_data['l'] < take_profit_price:
                    self.account.close_short_position('BTC', execution_price=take_profit_price_exec)
                    self.exit_reset()
                    if self.complex:
                        self.leverage += 0.1
            if self.longing:
                take_profit_price = self.entry_price * (1 + take_profit)
                stop_loss_price = self.entry_price * (1 + stop_loss)
                take_profit_price_exec = self.entry_price * (1 + take_profit * self.leverage)
                stop_loss_price_exec = self.entry_price * (1 + stop_loss * self.leverage)
                # Take profit / Stop loss
                if new_data['l'] < stop_loss_price:
                    self.account.close_long_position('BTC', execution_price=stop_loss_price_exec)
                    self.exit_reset()
                elif new_data['h'] > take_profit_price:
                    self.account.close_long_position('BTC', execution_price=take_profit_price_exec)
                    self.exit_reset()
        else:
            if short_flag:
                # Short
                self.account.short_underlying('BTC')
                self.shorting = True
                self.holding_days = 0
                self.entry_price = new_data['c']
                self.entry_asset = self.account.get_total_asset()
            elif long_flag:
                # Long
                self.account.long_underlying('BTC')
                self.longing = True
                self.holding_days = 0
                self.entry_price = new_data['c']
                self.entry_asset = self.account.get_total_asset()
        self.last_data = new_data
        self.started = True
        return 0


if __name__ == "__main__":
    strat = RandomForestStrategy()
