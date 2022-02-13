from account import Account


class BaseStrategy:
    def __init__(self):
        self.market = None
        self.account = Account()

    def load_market(self, market):
        self.market = market
        self.account.reset()
        self.account.load_market(market)
        self.reset()
        pass

    def add_metrics(self):
        pass

    def reset(self):
        pass

    def step(self):
        raise NotImplementedError()

