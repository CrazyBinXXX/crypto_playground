from account import Account
from simu_market import SimuMarket
from constants import *
from strategies import BaseStrategy
import pandas as pd
from typing import Callable
import numpy as np


class BollingKingStrategy(BaseStrategy):
    def __init__(self):
        super().__init__()
        self.last_data = None
        self.longing = False
        self.shorting = False
        self.entry_asset = 0
        self.trade_num = 0

    def load_market(self, market, init_cash):
        super().load_market(market, init_cash)
        self.trade_num = 0

    def reset(self):
        self.last_data = None

    @staticmethod
    def extend_market(market_data):
        # Define function to calculate the RSI
        def calc_rsi(over: pd.Series, fn_roll: Callable, length) -> pd.Series:
            # Get the difference in price from previous step
            delta = over.diff()
            # Get rid of the first row, which is NaN since it did not have a previous row to calculate the differences
            delta = delta[1:]

            # Make the positive gains (up) and negative gains (down) Series
            up, down = delta.clip(lower=0), delta.clip(upper=0).abs()

            roll_up, roll_down = fn_roll(up), fn_roll(down)
            rs = roll_up / roll_down
            rsi = 100.0 - (100.0 / (1.0 + rs))

            # Avoid division-by-zero if `roll_down` is zero
            # This prevents inf and/or nan values.
            rsi[:] = np.select([roll_down == 0, roll_up == 0, True], [100, 0, rsi])
            rsi.name = 'rsi'

            # Assert range
            valid_rsi = rsi[length - 1:]
            assert ((0 <= valid_rsi) & (valid_rsi <= 100)).all()
            # Note: rsi[:length - 1] is excluded from above assertion because it is NaN for SMA.

            return rsi

        market_data['o'] = market_data['o'].astype(float)
        market_data['h'] = market_data['h'].astype(float)
        market_data['l'] = market_data['l'].astype(float)
        market_data['c'] = market_data['c'].astype(float)
        market_data['v'] = market_data['v'].astype(float)
        market_data['ohlc'] = market_data.apply(lambda x: (x['o'] + x['h'] + x['l'] + x['c']) / 4, axis=1)
        market_data['bolling_m'] = market_data['c'].rolling(200).apply(lambda x: x.mean())
        market_data['bolling_2u'] = market_data['c'].rolling(200).apply(lambda x: x.mean() + 2 * x.std())
        market_data['bolling_2l'] = market_data['c'].rolling(200).apply(lambda x: x.mean() - 2 * x.std())
        market_data['bolling_bull'] = market_data.apply(lambda x: x['o'] < x['bolling_2l'] and x['c'] > x['bolling_2l'], axis=1)
        market_data['bolling_bear'] = market_data.apply(lambda x: x['o'] > x['bolling_2u'] and x['c'] < x['bolling_2u'], axis=1)
        market_data['volatility'] = market_data['bolling_2u'] - market_data['bolling_2l']
        market_data['base_vol'] = market_data['volatility'].rolling(2000).mean()
        market_data['base_vol'] = market_data['base_vol'].fillna(method='bfill')
        market_data['vol_too_high'] = market_data.apply(lambda x: x['volatility'] > 1.5 * x['base_vol'], axis=1)
        market_data['rsi'] = 0
        market_data['rsi'].iloc[1:] = calc_rsi(market_data['c'], lambda s: s.ewm(alpha=1 / 6).mean(), 6).values
        market_data['rsi_bull_cross'] = market_data['rsi'].rolling(2).apply(lambda x: x[0] < 50 and x[1] > 50)
        market_data['rsi_bear_cross'] = market_data['rsi'].rolling(2).apply(lambda x: x[0] > 50 and x[1] < 50)
        market_data['rsi_bull'] = market_data['rsi_bull_cross'].rolling(10).apply(lambda x: np.any(np.array(x)))
        market_data['rsi_bear'] = market_data['rsi_bear_cross'].rolling(10).apply(lambda x: np.any(np.array(x)))
        market_data['trendEMA'] = market_data['c'].ewm(span=1500, adjust=False).mean()
        market_data['trend_bull'] = market_data.apply(lambda x: x['c'] > x['trendEMA'], axis=1)
        market_data['trend_bear'] = market_data.apply(lambda x: x['c'] < x['trendEMA'], axis=1)
        market_data['long_signal'] = market_data.apply(
            lambda x: x['bolling_bull'] and x['rsi_bull'] and x['trend_bull'] and not x['vol_too_high'], axis=1)
        market_data['short_signal'] = market_data.apply(
            lambda x: x['bolling_bear'] and x['rsi_bear'] and x['trend_bear'] and not x['vol_too_high'], axis=1)
        return market_data

    def step(self):
        new_data = self.market.get_next_data()
        stop_loss = 0.99
        if self.entry_asset and self.account.get_total_asset() / self.entry_asset < 0.99:
            # Stop Loss
            if self.longing:
                self.account.close_long_position('BTC')
                self.longing = False
            elif self.shorting:
                self.account.close_short_position('BTC')
                self.shorting = False
        # if self.entry_asset and self.account.get_total_asset() / self.entry_asset > 1.2:
        #     # Take Profit
        #     if self.longing:
        #         self.account.close_long_position('BTC')
        #         self.longing = False
        #         print("Close long at {0}".format(new_data['c']))
        #         print("Trade Return: {0}".format(self.account.get_total_asset() / self.entry_asset - 1))
        #     elif self.shorting:
        #         self.account.close_short_position('BTC')
        #         self.shorting = False
        #         print("Close short at {0}".format(new_data['c']))
        #         print("Trade Return: {0}".format(self.account.get_total_asset() / self.entry_asset - 1))
        if self.longing or self.shorting:
            # Take Profit
            if self.longing and new_data['o'] > new_data['bolling_2u'] > new_data['l']:
                self.account.close_long_position('BTC')
                self.longing = False
            elif self.shorting and new_data['o'] < new_data['bolling_2l'] < new_data['h']:
                self.account.close_short_position('BTC')
                self.shorting = False
        # if self.longing or self.shorting:
        #     # Stop Loss
        #     if self.longing and new_data['trend_bear']:
        #         self.account.close_long_position('BTC')
        #         self.longing = False
        #     elif self.shorting and new_data['trend_bull']:
        #         self.account.close_short_position('BTC')
        #         self.shorting = False

        # Take Action
        # if not (self.longing or self.shorting) and new_data['long_signal'] == "True":
        #     self.account.long_underlying('BTC')
        #     self.longing = True
        #     self.entry_asset = self.account.get_total_asset()
        if not (self.longing or self.shorting) and new_data['short_signal'] == "True":
            self.account.short_underlying('BTC')
            self.shorting = True
            self.entry_asset = self.account.get_total_asset()
        return 0


if __name__ == "__main__":
    strat = BollingKingStrategy()
    sm = SimuMarket()
    data_path = ROOT_PATH + "/dataHouse/BTCUSDT_2021-01-01-2021-12-31_15m.csv"
    sm.load_data(data_path)
    strat.load_market(sm)
    for i in range(10):
        strat.step()
