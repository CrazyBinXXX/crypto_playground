class BaseStrategy:
    def __init__(self):
        self.market = None

    def load_market(self, market):
        self.market = market
        pass

    def step(self):
        raise NotImplementedError()
