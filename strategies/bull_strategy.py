from account import Account
from simu_market import SimuMarket
from constants import *
from strategies import BaseStrategy


class BullStrategy(BaseStrategy):
    def __init__(self):
        super().__init__()
        self.last_data = None
        self.longing = False
        self.shorting = False
        self.entry_asset = 0

    def reset(self):
        self.last_data = None
        self.longing = False
        self.shorting = False
        self.entry_asset = 0

    def step(self):
        new_data = self.market.get_next_data()
        if self.entry_asset and self.account.get_total_asset() / self.entry_asset < 0.97:
            # Stop Loss
            if self.longing:
                self.account.close_long_position('BTC')
                self.longing = False
            elif self.shorting:
                self.account.close_short_position('BTC')
                self.shorting = False
        if self.longing or self.shorting:
            # Take Profit
            if self.longing and new_data['o'] < new_data['bolling_2u'] < new_data['c']:
                self.account.close_long_position('BTC')
                self.longing = False
        # Take Action
        if not (self.longing or self.shorting) and new_data['trend_bull'] and new_data['o'] > new_data['bolling_m']:
            self.account.long_underlying('BTC')
            self.longing = True
            self.entry_asset = self.account.get_total_asset()
        return 0


if __name__ == "__main__":
    pass