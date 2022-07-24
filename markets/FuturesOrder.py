from enum import Enum
from common.Global import *
from Side import Side


class OrderType(Enum):
    MAKER_START = 0,  # maker under this

    TAKE_PROFIT_LIMIT = 1,
    STOP_LOSS_LIMIT = 1,
    LIMIT_LOWER = 3,
    LIMIT_HIGHER = 4,

    TAKER_START = 5,  # taker under this
    MARKET = 6,
    TAKE_PROFIT_MARKET = 7,
    STOP_LOSS_MARKET = 8,


class FuturesOrder:
    def __init__(self, account):
        self.side: Side = Side.BUY  # 1 for buy, -1 for sell
        self.unrealized_pnl = 0
        self.leverage = 1
        self.last_price = None
        self.margin = None
        self.is_filled = False
        self.account = account
        self.timestamp = None
        self.type = None
        self.fee = 0

    def open(self, side, price, margin, type: OrderType, leverage=1):
        self.side = side
        self.last_price = price
        self.margin = margin
        self.leverage = leverage
        self.type = type

        if self.type == OrderType.MARKET:
            self.__fill()

    def __fill(self):
        self.is_filled = True
        self.calc_fee(self.margin)

    def calc_fee(self, execute_amount):
        if self.type > OrderType.MAKER_START:
            self.fee += execute_amount * Config.MAKER_FEE
        else:
            self.fee += execute_amount * Config.TAKER_FEE

    def stats(self):
        return {
            "margin": self.margin,
            "leverage": self.leverage,
            "filled": self.is_filled,
            "unrealized_pnl": self.unrealized_pnl,
            "timestamp": self.timestamp,
            "fee": self.fee,
        }
