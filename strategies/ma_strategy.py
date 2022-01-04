from simu_market import SimuMarket
from constants import *
from strategies import BaseStrategy


class MAStrategy(BaseStrategy):
    def __init__(self):
        super().__init__()
        self.market = None

    def set_market(self, market):
        self.market = market

    def step(self):
        new_data = self.market.get_next_data()
        if new_data == SIMULATION_END:
            return SIMULATION_END
        print(new_data)
        return None


if __name__ == "__main__":
    strat = MAStrategy()
