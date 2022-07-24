from account.Account import *
from markets.SimuMarkets import *

class SampleStrategy:
    def __init__(self, account):
        self.account = account

    def step(self, data):
        # strategy logic goes here
        print(data)


if __name__ == '__main__':
    market = SimuMarket()
    account = FuturesAccount(3000, market)
    strategy = SampleStrategy(account)
    market.load_data_csv("/path/to/csv")

    market.add_callback(strategy.step)

    market.run()