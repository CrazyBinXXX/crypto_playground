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

    def __init__(self, leverage=1, fast=False, complex=False, realTest=False, cautiousness=0.5):
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
        long_model_path = "../modelHouse/rf_long_model_5min_v0.5"
        self.rf_long_model = tf.keras.models.load_model(long_model_path)
        short_model_path = "../modelHouse/rf_short_model_5min_v0.5"
        self.rf_short_model = tf.keras.models.load_model(short_model_path)
        self.complex = complex
        self.fast = fast
        self.realTest = realTest
        self.cautiousness = cautiousness

    def load_market(self, market, init_cash):
        super().load_market(market, init_cash)

    @staticmethod
    def extend_market(market_data):
        return market_data

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
        if not self.realTest:
            new_data = self.market.get_next_data().iloc[0]
        else:
            new_data = self.market.get_next_data(2000)
        if self.holding_days > -1:
            self.holding_days += 1
        # Take Action
        if not self.fast:
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
        else:
            long_result = new_data['long_score']
            short_result = new_data['short_score']

        gap = 0.0
        # long_flag = long_result > self.cautiousness and long_result > short_result + gap
        long_flag = False
        short_flag = short_result > self.cautiousness and short_result > long_result + gap

        if self.shorting or self.longing:
            # Decide whether to exit
            take_profit = 0.02
            stop_loss = -0.01
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

    @staticmethod
    def static_long_short_signal(recent_2000_df, long_model, short_model, cautiousness):
        alphas = RandomForestStrategy.calc_alphas(recent_2000_df)
        alphas_ds = tfdf.keras.pd_dataframe_to_tf_dataset(alphas)
        long_model_result = long_model.predict(alphas_ds)[0][0]
        short_model_result = short_model.predict(alphas_ds)[0][0]
        long_signal = long_model_result > cautiousness
        short_signal = short_model_result > cautiousness
        if long_signal and short_signal:
            long_signal = long_model_result > short_model_result
            short_signal = long_model_result <= short_model_result
        return long_signal, short_signal

    @staticmethod
    def calc_alphas(input):
        output_dict = {}
        output_cols = ['vol_too_high', 'trend_bull', 'trend_bear', '10_c_log_return',
                       '30_c_log_return', '60_c_log_return', '10_c_bull', '30_c_bull',
                       '60_c_bull', 'bolling_bull', 'bolling_bear', 'o_relative', 'h_relative',
                       'l_relative', 'c_relative', 'v_relative', 'long_signal', 'short_signal',
                       'alpha_6', 'alpha_12']
        for col in output_cols:
            output_dict[col] = []

        input_df = input.copy()

        input_df.loc[:, 'o'] = input_df['o'].astype(float)
        input_df.loc[:, 'h'] = input_df['h'].astype(float)
        input_df.loc[:, 'l'] = input_df['l'].astype(float)
        input_df.loc[:, 'c'] = input_df['c'].astype(float)
        input_df.loc[:, 'v'] = input_df['v'].astype(float)
        input_df.loc[:, '200std'] = input_df.iloc[-200:]['c'].rolling(200).apply(lambda x: x.std())
        input_df.loc[:, '200_v_std'] = input_df[-200:]['v'].rolling(200).apply(lambda x: x.std())
        input_df.loc[:, '200_ma_volume'] = input_df[-200:]['v'].rolling(200).apply(lambda x: x.mean())
        input_df.loc[:, 'bolling_m'] = input_df[-200:]['c'].rolling(200).apply(lambda x: x.mean())
        input_df.loc[:, 'bolling_2u'] = input_df[-200:]['c'].rolling(200).apply(lambda x: x.mean() + 2 * x.std())
        input_df.loc[:, 'bolling_2l'] = input_df['c'].rolling(200).apply(lambda x: x.mean() - 2 * x.std())
        input_df.loc[:, 'volatility'] = input_df['bolling_2u'] - input_df['bolling_2l']
        input_df.loc[:, 'base_vol'] = input_df['volatility'].rolling(2000).mean()
        input_df.loc[:, 'base_vol'] = input_df['base_vol'].fillna(method='bfill')
        input_df.loc[:, 'vol_too_high'] = input_df.apply(lambda x: x['volatility'] > 1.5 * x['base_vol'], axis=1)
        input_df.loc[:, 'trendEMA'] = input_df['c'].ewm(span=1500, adjust=False).mean()
        input_df.loc[:, 'trend_bull'] = input_df.apply(lambda x: x['c'] > x['trendEMA'], axis=1)
        input_df.loc[:, 'trend_bear'] = input_df.apply(lambda x: x['c'] < x['trendEMA'], axis=1)
        input_df['10_c_ma'] = input_df['c'].rolling(10).apply(lambda x: x.mean())
        input_df['30_c_ma'] = input_df['c'].rolling(30).apply(lambda x: x.mean())
        input_df['60_c_ma'] = input_df['c'].rolling(60).apply(lambda x: x.mean())
        input_df['10_c_log_return'] = input_df['c'].rolling(10).apply(lambda x: math.log(x.iloc[9] / x.iloc[0]))
        input_df['30_c_log_return'] = input_df['c'].rolling(30).apply(lambda x: math.log(x.iloc[29] / x.iloc[0]))
        input_df['60_c_log_return'] = input_df['c'].rolling(60).apply(lambda x: math.log(x.iloc[59] / x.iloc[0]))

        input_df['10_c_bull'] = input_df.apply(lambda x: x['c'] > x['10_c_ma'], axis=1)
        input_df['30_c_bull'] = input_df.apply(lambda x: x['c'] > x['30_c_ma'], axis=1)
        input_df['60_c_bull'] = input_df.apply(lambda x: x['c'] > x['60_c_ma'], axis=1)

        input_df['10_c_log_return'] = input_df['c'].rolling(10).apply(lambda x: math.log(x.iloc[9] / x.iloc[0]))
        input_df['30_c_log_return'] = input_df['c'].rolling(30).apply(lambda x: math.log(x.iloc[29] / x.iloc[0]))
        input_df['60_c_log_return'] = input_df['c'].rolling(60).apply(lambda x: math.log(x.iloc[59] / x.iloc[0]))

        input_df['bolling_bull'] = input_df.apply(lambda x: x['o'] < x['bolling_2l'] and x['c'] > x['bolling_2l'],
                                                  axis=1)
        input_df['bolling_bear'] = input_df.apply(lambda x: x['o'] > x['bolling_2u'] and x['c'] < x['bolling_2u'],
                                                  axis=1)

        input_df.loc[:, 'o_relative'] = input_df.apply(lambda x: (x['o'] - x['bolling_m']) / x['200std'], axis=1)
        input_df.loc[:, 'h_relative'] = input_df.apply(lambda x: (x['h'] - x['bolling_m']) / x['200std'], axis=1)
        input_df.loc[:, 'l_relative'] = input_df.apply(lambda x: (x['l'] - x['bolling_m']) / x['200std'], axis=1)
        input_df.loc[:, 'c_relative'] = input_df.apply(lambda x: (x['c'] - x['bolling_m']) / x['200std'], axis=1)
        input_df.loc[:, 'v_relative'] = input_df.apply(lambda x: (x['v'] - x['200_ma_volume']) / x['200_v_std'], axis=1)

        input_df['long_signal'] = input_df.apply(
            lambda x: x['bolling_bull'] and x['trend_bull'] and not x['vol_too_high'], axis=1)
        input_df['short_signal'] = input_df.apply(
            lambda x: x['bolling_bear'] and x['trend_bear'] and not x['vol_too_high'], axis=1)

        # Alpha 6, ov against
        input_df['alpha_6'] = -1 * rolling_apply(lambda x, y: np.corrcoef([x, y])[0, 1], 10, input_df.o.values,
                                                 input_df.v.values)
        # Alpha 12, cv momentem
        input_df['1_v_log_ret'] = input_df['v'].rolling(2).apply(
            lambda x: math.log(x.iloc[1] / x.iloc[0]) if x.iloc[1] / x.iloc[0] > 0 else 0)
        input_df['1_c_log_ret'] = input_df['c'].rolling(2).apply(lambda x: math.log(x.iloc[1] / x.iloc[0]))
        input_df['alpha_12'] = input_df.apply(lambda x: (1 if x['1_v_log_ret'] > 0 else -1) * -1 * x['1_c_log_ret'],
                                              axis=1)

        output_df = pd.DataFrame.from_dict(output_dict) * 1
        last_row = input_df.iloc[-1]
        for col in output_cols:
            output_df[col] = [last_row[col]]
        return output_df * 1


if __name__ == "__main__":
    strat = RandomForestStrategy()
