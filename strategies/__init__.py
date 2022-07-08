from account import Account
from account.contract_accont import ContractAccount


class BaseStrategy:
    def __init__(self):
        self.market = None
        self.account = None

    def load_market(self, market, init_cash):
        self.market = market
        self.account = ContractAccount(market, init_cash)
        self.reset()
        pass

    def add_metrics(self):
        pass

    def reset(self):
        pass

    def step(self):
        raise NotImplementedError()

