from account import Account
from simu_market import SimuMarket
from constants import *
from strategies import BaseStrategy
import pandas as pd


class MAShortStrategy(BaseStrategy):
    def __init__(self):
        super().__init__()
        self.last_data = None
        self.longing = False
        self.shorting = False
        self.holding_limit = 96
        self.holding_days = -1
        self.entry_price = -1
        self.entry_asset = -1
        self.started = False

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

        market_data.loc[:, '100_ma_volume'] = market_data['v'].rolling(200).apply(lambda x: x.mean())
        return market_data.iloc[500:]

    def reset(self):
        self.last_data = None
        self.longing = False
        self.shorting = False
        self.holding_days = -1

    def step(self):
        new_data = self.market.get_next_data()
        if self.holding_days > -1:
            self.holding_days += 1
        # Take Action
        trend_factor = new_data['trend_bear']
        cross_bolling_factor = new_data['o'] > new_data['bolling_m'] > new_data['c']
        if self.started:
            cross_bolling_factor = cross_bolling_factor and \
                                   self.last_data['o'] > self.last_data['bolling_m'] and self.last_data['c'] > self.last_data['bolling_m']
        cross_bolling_u_factor = new_data['o'] > new_data['bolling_2u'] > new_data['c']
        low_vol_factor = not new_data['vol_too_high']
        high_volume_factor = new_data['v'] > new_data['100_ma_volume'] * 3
        short_flag = trend_factor and (cross_bolling_u_factor) and low_vol_factor
        # short_flag = high_volume_factor

        if short_flag and not self.shorting:
            # Short
            self.account.short_underlying('BTC')
            self.shorting = True
            self.holding_days = 0
            self.entry_price = new_data['c']
            self.entry_asset = self.account.get_total_asset()

        if self.shorting:
            # Decide whether to exit
            takeProfit = 0.05
            stopLoss = -0.025
            takeProfitPrice = self.entry_price / (1 + takeProfit)
            stopLossPrice = self.entry_price / (1 + stopLoss)
            # Take profit / Stop loss
            if new_data['h'] > stopLossPrice:
                self.account.close_short_position('BTC', execution_price=stopLossPrice)
                self.shorting = False
                self.holding_days = 0
                self.entry_price = -1
                self.entry_asset = -1
            elif new_data['l'] < takeProfitPrice:
                self.account.close_short_position('BTC', execution_price=takeProfitPrice)
                self.shorting = False
                self.holding_days = 0
                self.entry_price = -1
                self.entry_asset = -1
        self.last_data = new_data
        self.started = True
        return 0


if __name__ == "__main__":
    strat = MAShortStrategy()
    sm = SimuMarket()
    data_path = ROOT_PATH + "/dataHouse/data/cryptoPrices/BTCUSDT_2021-06-23-2022-06-23_1m.csv"
    df = pd.read_csv(data_path, index_col=0).iloc[-100100:-100]
    sm.load_df(df)
    strat.load_market(sm, 10000)
    for i in range(10):
        strat.step()
