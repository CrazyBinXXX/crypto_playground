from account import Account


class BaseStrategy:
    def __init__(self):
        self.market = None
        self.account = Account()

    def load_market(self, market):
        self.market = market
        self.account.load_market(market)
        pass

    def step(self):
        raise NotImplementedError()

