from account.Account import *
from markets.SimuMarkets import *


class SampleStrategy:
    def __init__(self, account):
        self.account = account

    def step(self, data):
        # strategy logic goes here
        print(data.data)

        # open order
        # self.account.open_order(...parameters)


if __name__ == '__main__':
    market = SimuMarket()
    account = FuturesAccount(3000, market)
    market.add_account(account)
    strategy = SampleStrategy(account)
    market.load_data_csv("/Users/borischen/PycharmProjects/crypto_backtest/data/last_500min.csv")
    market.add_callback(strategy.step)

    market.run()
