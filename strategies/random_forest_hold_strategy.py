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


class RandomForestHoldStrategy(BaseStrategy):

    def __init__(self, leverage=1, fast=False, complex=False, realTest=False, cautiousness=0.50):
        super().__init__()
        self.last_data = None
        self.longing = False
        self.shorting = False
        self.holding_limit = 5
        self.holding_days = -1
        self.entry_price = -1
        self.entry_asset = -1
        self.started = False
        self.frozen = 0
        self.max_holding = 9999999999999999
        self.high_volume_factor = 9
        self.leverage = leverage
        if not fast:
            long_model_path = "../modelHouse/rf_long_model_15min_hold_v0.1"
            self.rf_long_model = tf.keras.models.load_model(long_model_path)
            short_model_path = "../modelHouse/rf_short_model_15min_hold_v0.1"
            self.rf_short_model = tf.keras.models.load_model(short_model_path)
        self.complex = complex
        self.fast = fast
        self.realTest = realTest
        self.cautiousness = cautiousness

    def load_market(self, market, init_cash):
        super().load_market(market, init_cash)

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
            input_cols = ['vol_too_high',
                     'trend_bull',
                     'alpha_bin',
                     'alpha_54',
                     'alpha_101',
                     'alpha_41',
                     'past_strength',
                     'alpha_6',
                     'alpha_12']
            for col in input_cols:
                input_dict[col] = [new_data[col]]
            input_df = pd.DataFrame.from_dict(input_dict) * 1
            input_ds = tfdf.keras.pd_dataframe_to_tf_dataset(input_df)

            long_result = self.rf_long_model.predict(input_ds)[0][0]
            short_result = self.rf_short_model.predict(input_ds)[0][0]
        else:
            long_result = new_data['long_score']
            short_result = new_data['short_score']

        gap = 0.10
        long_flag = long_result > self.cautiousness and long_result > short_result + gap
        short_flag = short_result > self.cautiousness and short_result > long_result + gap
        strength = long_result - short_result

        if self.shorting or self.longing:
            # Decide whether to exit
            # self.holding_days += 1
            # if self.holding_days >= self.holding_limit:
            #     if self.longing:
            #         self.account.close_long_position('BTC', execution_price=new_data['c'])
            #         self.exit_reset()
            #     elif self.shorting:
            #         self.account.close_short_position('BTC', execution_price=new_data['c'])
            #         self.exit_reset()
            if strength < -0.05 and self.longing:
                self.account.close_long_position('BTC', execution_price=new_data['c'])
                self.exit_reset()
            elif strength > 0.05 and self.shorting:
                self.account.close_short_position('BTC', execution_price=new_data['c'])
                self.exit_reset()
        else:
            if strength < -0.05:
                # Short
                self.account.short_underlying('BTC')
                self.shorting = True
                self.holding_days = 0
                self.entry_price = new_data['c']
                self.entry_asset = self.account.get_total_asset()
            elif strength > 0.05:
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
