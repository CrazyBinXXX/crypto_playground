from simu_market import SimuMarket


class Account:
    def __init__(self):
        self.cash = 0
        self.positions = {}
        self.market = None

    def load_market(self, market: SimuMarket):
        self.market = market

    def set_cash(self, target):
        self.cash = target

    def add_money(self, amount):
        self.cash += amount

    def buy(self, symbol: str, execution_price, amount):
        real_amount = min(amount, self.cash / execution_price)
        self.cash -= real_amount * execution_price
        if symbol in self.positions:
            self.positions[symbol] += real_amount
        else:
            self.positions[symbol] = real_amount

    def buy_all(self, symbol: str, execution_price):
        real_amount = self.cash / execution_price
        self.cash -= real_amount * execution_price
        if symbol in self.positions:
            self.positions[symbol] += real_amount
        else:
            self.positions[symbol] = real_amount

    def sell(self, symbol: str, execution_price, amount):
        if symbol not in self.positions:
            return
        real_amount = min(amount, self.positions[symbol])
        self.positions[symbol] -= real_amount
        self.cash += real_amount * execution_price

    def sell_all(self, symbol: str, execution_price):
        if symbol in self.positions:
            self.cash += self.positions[symbol] * execution_price
            self.positions[symbol] = 0
        else:
            return

    def get_total_asset(self):
        ret = self.cash
        for k, v in self.positions.items():
            ret += v * self.market.get_cur_data()['c']
        return ret
