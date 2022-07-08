from simu_market import SimuMarket
from constants import SPOT_FEE, MARKET_ORDER_PENALTY


class BaseAccount:
    def __init__(self, market: SimuMarket, init_cash):
        self.cash = 0
        self.market = None
        self.load_market(market)
        self.set_init_cash(init_cash)

    def set_init_cash(self, init_cash):
        self.cash = init_cash

    def load_market(self, market):
        self.market = market


class Account:
    def __init__(self):
        self.init_cash = 0
        self.cash = 0
        self.mortgage = 0
        self.trading_fee = 0
        self.init_positions = {}
        self.positions = {}
        self.market = None

    def reset(self):
        self.set_cash(self.init_cash)
        self.positions = {}
        self.trading_fee = 0

    def load_market(self, market: SimuMarket):
        self.market = market

    def set_init_cash(self, init_cash):
        self.init_cash = init_cash
        self.set_cash(init_cash)

    def set_cash(self, target):
        self.cash = target

    def add_money(self, amount):
        self.cash += amount

    def buy(self, symbol: str, amount):
        execution_price = self.market.get_cur_data()['c'] * (1 + MARKET_ORDER_PENALTY)
        real_amount = min(amount, self.cash / execution_price)
        volume = real_amount * execution_price
        self.cash -= real_amount * execution_price
        if symbol in self.positions:
            self.positions[symbol] += real_amount
        else:
            self.positions[symbol] = real_amount
        self.trading_fee += volume * SPOT_FEE

    def buy_at_price(self, symbol: str, amount, price):
        execution_price = price
        real_amount = min(amount, self.cash / execution_price)
        volume = real_amount * execution_price
        self.cash -= real_amount * execution_price
        if symbol in self.positions:
            self.positions[symbol] += real_amount
        else:
            self.positions[symbol] = real_amount
        self.trading_fee += volume * SPOT_FEE

    def buy_all(self, symbol: str):
        execution_price = self.market.get_cur_data()['c'] * (1 + MARKET_ORDER_PENALTY)
        real_amount = self.cash / execution_price
        self.buy(symbol, real_amount)

    def buy_all_at_price(self, symbol: str, price):
        execution_price = price
        real_amount = self.cash / execution_price
        self.buy_at_price(symbol, real_amount, execution_price)

    def short_at_price(self, symbol, amount, price):
        execution_price = price
        real_amount = min(amount, self.cash / execution_price)
        volume = real_amount * execution_price
        self.cash -= real_amount * execution_price
        self.mortgage += real_amount * execution_price * 2
        if symbol in self.positions:
            self.positions[symbol] -= real_amount
        else:
            self.positions[symbol] = -real_amount
        self.trading_fee += volume * SPOT_FEE

    def short_all_at_price(self, symbol: str, price):
        execution_price = price
        real_amount = max(0, self.cash / execution_price)
        self.short_at_price(symbol, real_amount, execution_price)

    def close_all_at_price(self, symbol, price):
        execution_price = price
        if symbol not in self.positions:
            return
        real_amount = max(0, -self.positions[symbol])
        volume = real_amount * execution_price
        self.positions[symbol] += real_amount
        self.cash += self.mortgage
        self.mortgage = 0
        self.cash -= volume
        self.trading_fee += volume * SPOT_FEE

    def sell(self, symbol: str, amount):
        execution_price = self.market.get_cur_data()['c'] * (1 - MARKET_ORDER_PENALTY)
        if symbol not in self.positions:
            return
        real_amount = min(amount, self.positions[symbol])
        self.positions[symbol] -= real_amount
        volume = real_amount * execution_price
        self.cash += real_amount * execution_price
        self.trading_fee += volume * SPOT_FEE

    def sell_at_price(self, symbol: str, amount, price):
        execution_price = price * (1 - MARKET_ORDER_PENALTY)
        if symbol not in self.positions:
            return
        real_amount = min(amount, self.positions[symbol])
        self.positions[symbol] -= real_amount
        volume = real_amount * execution_price
        self.cash += real_amount * execution_price
        self.trading_fee += volume * SPOT_FEE

    def sell_all(self, symbol: str):
        execution_price = self.market.get_cur_data()['c'] * (1 - MARKET_ORDER_PENALTY)
        self.sell(symbol, self.positions[symbol])

    def sell_all_at_price(self, symbol: str, price):
        execution_price = price
        self.sell_at_price(symbol, self.positions[symbol], price)

    def get_total_asset(self):
        ret = self.cash
        ret += self.mortgage
        for k, v in self.positions.items():
            ret += v * self.market.get_cur_data()['c']
        ret -= self.trading_fee
        return ret
