from account import Account
from simu_market import SimuMarket
from constants import *
from strategies import BaseStrategy
import pandas as pd


class CodeBullStrategy(BaseStrategy):
    def __init__(self, leverage=1):
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
        trend_bear_factor = new_data['trend_bear']
        trend_bull_factor = new_data['trend_bull']
        cross_bolling_factor = new_data['o'] > new_data['bolling_m'] > new_data['c']
        if self.started:
            cross_bolling_factor = cross_bolling_factor and \
                                   self.last_data['o'] > self.last_data['bolling_m'] and self.last_data['c'] > self.last_data['bolling_m']
        cross_bolling_u_factor = new_data['o'] > new_data['bolling_2u'] > new_data['c']
        cross_bolling_l_factor = new_data['o'] < new_data['bolling_2l'] < new_data['c']
        low_vol_factor = not new_data['vol_too_high']
        high_volume_factor = new_data['v'] > new_data['100_ma_volume'] * self.high_volume_factor
        short_flag = trend_bear_factor and (cross_bolling_u_factor) and low_vol_factor
        long_flag = trend_bull_factor and cross_bolling_l_factor and low_vol_factor
        short_flag = (high_volume_factor and new_data['o'] > new_data['c']) or short_flag
        short_flag = False
        # long_flag = (high_volume_factor and new_data['o'] < new_data['c']) or long_flag
        long_flag = False

        if self.started:
            long_flag = new_data['c'] > self.last_data['MATR'] * 2 + self.last_data['c']
            short_flag = new_data['c'] < self.last_data['c'] - self.last_data['MATR']

        long_flag = new_data['ema'] > new_data['sma']
        short_flag = new_data['sma'] > new_data['ema']

        if self.shorting or self.longing:
            # Decide whether to exit
            takeProfit = 5
            stopLoss = -5
            if self.shorting:
                if self.holding_days > self.max_holding:
                    # Force quit if holding too long
                    self.account.close_short_position('BTC', execution_price=new_data['c'])
                    self.exit_reset()
                take_profit_price = self.entry_price / (1 + takeProfit)
                stop_loss_price = self.entry_price / (1 + stopLoss)
                take_profit_price_exec = self.entry_price / (1 + takeProfit * self.leverage)
                stop_loss_price_exec = self.entry_price / (1 + stopLoss * self.leverage)
                # Take profit / Stop loss
                if new_data['h'] > stop_loss_price:
                    self.account.close_short_position('BTC', execution_price=stop_loss_price_exec)
                    self.exit_reset()
                elif new_data['l'] < take_profit_price:
                    self.account.close_short_position('BTC', execution_price=take_profit_price_exec)
                    self.exit_reset()
            if self.longing:
                if self.holding_days > self.max_holding:
                    # Force quit if holding too long
                    self.account.close_long_position('BTC', execution_price=new_data['c'])
                    self.exit_reset()
                take_profit_price = self.entry_price * (1 + takeProfit)
                stop_loss_price = self.entry_price * (1 + stopLoss)
                take_profit_price_exec = self.entry_price * (1 + takeProfit * self.leverage)
                stop_loss_price_exec = self.entry_price * (1 + stopLoss * self.leverage)
                # Take profit / Stop loss
                if new_data['l'] < stop_loss_price:
                    self.account.close_long_position('BTC', execution_price=stop_loss_price_exec)
                    self.exit_reset()
                elif new_data['h'] > take_profit_price:
                    self.account.close_long_position('BTC', execution_price=take_profit_price_exec)
                    self.exit_reset()
                elif short_flag:
                    self.account.close_long_position('BTC', execution_price= self.entry_price + self.leverage * (new_data['c'] - self.entry_price))
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
    pass
