import sys

import numpy as np

sys.path.append("/Users/borischen/PycharmProjects/crypto_backtest")
np.array([1, 2, 3])
pass

from account.Account import *
from markets.SimuMarkets import *


class SampleStrategy:
    def __init__(self, account, market):
        self.account = account
        self.market = market
        self.data = []
        self.last_MA_7 = None
        self.last_MA_25 = None

    def step(self, data):
        self.data.append(data.close)

        # process signal
        if len(self.data) == 25:
            self.last_MA_7 = np.mean(self.data[-7:])
            self.last_MA_25 = np.mean(self.data[-25:])
        elif len(self.data) > 25:
            cur_MA_7 = np.mean(self.data[-7:])
            cur_MA_25 = np.mean(self.data[-25:])
            if self.account.get_position() is None:
                self.account.remove_all_order()

            if self.last_MA_7 < self.last_MA_25 and cur_MA_7 > cur_MA_25:
                price = market.get_price().close

                if self.account.get_position() is not None:
                    self.account.open_order(Side.BUY, None, 0, OrderType.MARKET)
                    self.account.remove_all_order()

                # open long
                margin = self.account.balance / 2
                self.account.open_order(Side.BUY, margin, price, OrderType.MARKET, 10)
                self.account.open_order(Side.SELL, None, price * (1 + 0.1 * 0.01), OrderType.TAKE_PROFIT_MARKET)
                self.account.open_order(Side.SELL, None, price * (1 - 2 * 0.01), OrderType.STOP_LOSS_MARKET)
            elif self.last_MA_7 > self.last_MA_25 and cur_MA_7 < cur_MA_25:
                # open short
                price = market.get_price().close
                if self.account.get_position() is not None:
                    self.account.open_order(Side.SELL, None, 0, OrderType.MARKET)
                    self.account.remove_all_order()

                margin = self.account.balance / 2
                self.account.open_order(Side.SELL, margin, price, OrderType.MARKET, 10)
                self.account.open_order(Side.BUY, None, price * (1 - 0.1 * 0.01), OrderType.TAKE_PROFIT_MARKET)
                self.account.open_order(Side.BUY, None, price * (1 + 2 * 0.01), OrderType.STOP_LOSS_MARKET)

            self.last_MA_7 = cur_MA_7
            self.last_MA_25 = cur_MA_25


DATALOG.clear()
market = SimuMarket()
account = FuturesAccount(3000, market)
market.add_account(account)
strategy = SampleStrategy(account, market)
market.load_data_csv("/Users/borischen/PycharmProjects/crypto_backtest/data/last_500min.csv")
start_index = 525499 - 100
market.index = start_index
market.add_callback(strategy.step)

market.run()
