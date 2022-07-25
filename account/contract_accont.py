from account import BaseAccount
from simu_market import SimuMarket
from constants import SPOT_FEE, MARKET_ORDER_PENALTY
from collections import defaultdict


class LongPositionInfo:
    def __init__(self, amount=0, avg_cost=0):
        self.amount = amount
        self.avg_cost = avg_cost

    def avg_new_position(self, adding_amount, adding_avg_cost):
        self.avg_cost = (self.avg_cost * self.amount + adding_avg_cost * adding_amount) / (self.amount + adding_amount)
        self.amount = self.amount + adding_amount


class ShortPositionInfo:
    def __init__(self, amount=0, avg_margin=0):
        self.amount = amount
        self.avg_margin = avg_margin

    def avg_new_position(self, adding_amount, adding_avg_margin):
        self.avg_margin = (self.avg_margin * self.amount + adding_avg_margin * adding_amount) / (self.amount + adding_amount)
        self.amount = self.amount + adding_amount


class TradeInfo:
    def __init__(self, time=0, value=0, type="Open Long", profit=0):
        self.time = time
        self.value = value
        self.type = type
        self.profit = profit

    def __str__(self):
        return 'Trading time: {0}\n'.format(self.time) +\
                'Volume: {0}\n'.format(self.value) + \
               'Type: {0}\n'.format(self.type) + \
                'Profit: {0}\n'.format(self.profit) + \
                'Return: {0}%\n'.format(round((self.profit / (self.value - self.profit)) * 100, 2))


def default_account():
    ret = {"Long Positions": LongPositionInfo(), "Short Positions": ShortPositionInfo()}
    return ret


class ContractAccount(BaseAccount):
    def __init__(self, market: SimuMarket, init_cash):
        super(ContractAccount, self).__init__(market, init_cash)
        self.positions = defaultdict(default_account)
        self.trade_num = 0
        self.trade_history = []
        self.trading_fee = 0

    def record_trade_info(self, time, value, type, profit):
        info = TradeInfo(time, value, type, profit)
        self.trade_history.append(info)
        self.trade_num += 1

    """
    -1 represents default value: allin & close
    """
    def long_underlying(self, underlying, amount=-1, execution_price=-1):
        if execution_price == -1:
            # Buy on close
            execution_price = self.market.get_cur_price(underlying)['c']
        max_amount = max(self.cash, 0) / execution_price
        if amount == -1 or amount > max_amount:
            # All in
            amount = max_amount
        amount = min(max_amount, amount)

        volume = amount * execution_price
        self.cash -= volume
        self.positions[underlying]["Long Positions"].avg_new_position(amount, execution_price)
        self.record_trade_info(self.market.get_cur_date(), volume, "Open Long", 0)
        self.trading_fee += volume * SPOT_FEE

    def close_long_position(self, underlying, amount=-1, execution_price=-1):
        if execution_price == -1:
            # Sell at close price
            execution_price = self.market.get_cur_price(underlying)['c']
        max_amount = self.positions[underlying]["Long Positions"].amount
        if amount == -1 or amount > max_amount:
            amount = max_amount

        volume = amount * execution_price
        self.positions[underlying]["Long Positions"].amount -= amount
        self.cash += volume
        self.record_trade_info(self.market.get_cur_date(), volume, "Close Long", volume- amount * self.positions[underlying]["Long Positions"].avg_cost)
        self.trading_fee += volume * SPOT_FEE

    def short_underlying(self, underlying, amount=-1, execution_price=-1):
        if execution_price == -1:
            # Short at close price
            execution_price = self.market.get_cur_price(underlying)['c']
        max_amount = max(self.cash, 0) / execution_price
        if amount == -1 or amount > max_amount:
            # All in
            amount = max_amount

        volume = amount * execution_price
        self.cash -= volume
        self.positions[underlying]["Short Positions"].avg_new_position(amount, execution_price)
        self.record_trade_info(self.market.get_cur_date(), volume, "Open Short", 0)
        self.trading_fee += volume * SPOT_FEE

    def close_short_position(self, underlying, amount=-1, execution_price=-1):
        if execution_price == -1:
            execution_price = self.market.get_cur_price(underlying)['c']
        max_amount = self.positions[underlying]["Short Positions"].amount
        if amount == -1 or amount > max_amount:
            amount = max_amount

        volume = amount * execution_price
        total_margin = self.positions[underlying]["Short Positions"].avg_margin * amount
        self.positions[underlying]["Short Positions"].amount -= amount
        self.cash += total_margin * 2 - amount * execution_price
        self.record_trade_info(self.market.get_cur_date(), volume, "Close Short", total_margin - volume)
        self.trading_fee += volume * SPOT_FEE

    def get_total_asset(self):
        total_asset = self.cash
        for underlying, position in self.positions.items():
            total_asset += position["Long Positions"].amount * self.market.get_cur_price(underlying)['c']
            total_asset += position["Short Positions"].amount * position["Short Positions"].avg_margin * 2 -\
                           position["Short Positions"].amount * self.market.get_cur_price(underlying)['c']
        total_asset -= self.trading_fee
        return total_asset

    def pretty_print(self):
        print("Account Info:")
        print("Total Asset:")
        print(self.get_total_asset())
        print("Num of Trades:")
        print(self.trade_num // 2)
        print("Each trade:")
        for i, trade in enumerate(self.trade_history):
            # if trade.profit != 0:
                print(trade)
        print("Total trading cost:")
        print(self.trading_fee)
        print("Win rate:")
        cnt = 0
        for trade in self.trade_history:
            cnt += 1 if trade.profit > 0 else 0
        if cnt > 0:
            print(str(round(cnt / (self.trade_num // 2) * 100, 2)) + "%")

