import unittest

from account.Account import FuturesAccount
from common.KLine import KLine
from markets.FuturesOrder import OrderType
from markets.Side import Side
from markets.SimuMarkets import SimuMarket

TEST_DATA_PATH = "/Users/borischen/PycharmProjects/crypto_backtest/tests/test_market.csv"


class OrderTestClass(unittest.TestCase):
    def init_market(self):
        market = SimuMarket()
        market.load_data_csv(TEST_DATA_PATH)
        return market

    def set_up_market_and_account(self, amount):
        market = self.init_market()
        account = FuturesAccount(amount, market)
        market.add_account(account)
        return market, account

    def test_open_long(self):
        market, account = self.set_up_market_and_account(1000)
        account.open_order(Side.BUY, 100, 0, OrderType.MARKET, 2)

        self.assertEqual(account.balance, 899.97)
        position = account.get_position()
        self.assertIsNotNone(position)
        self.assertEqual(position.balance(), 100)

    def test_open_long_and_take_profit(self):
        market, account = self.set_up_market_and_account(1000)
        account.open_order(Side.BUY, 100, 0, OrderType.MARKET, 2)
        account.open_order(Side.SELL, None, 1100, OrderType.TAKE_PROFIT_MARKET)
        market.step()

        self.assertAlmostEqual(account.balance, 1019.934)

    def test_open_long_and_stop_loss(self):
        market, account = self.set_up_market_and_account(1000)
        account.open_order(Side.BUY, 100, 0, OrderType.MARKET, 2)
        account.open_order(Side.SELL, None, 950, OrderType.STOP_LOSS_MARKET)
        market.step()

        self.assertAlmostEqual(account.balance, 989.943)

    def test_open_short_and_take_profie(self):
        market = self.init_market()
        account = FuturesAccount(1000, market)
        account.open_order(Side.SELL, 100, 1000, OrderType.MARKET, 1)
        account.open_order(Side.BUY, 110, 900, OrderType.TAKE_PROFIT_MARKET, 1)
        self.assertEqual(account.balance, 899.97)
        position = account.get_position()
        self.assertIsNotNone(position)
        self.assertEqual(position.balance(), 100)

        new_price = KLine(900, 1200, 1000, 900, "0")
        account.update_price(new_price)
        self.assertIsNone(account.position)
        self.assertEqual(len(account.order_list), 0)
        self.assertEqual(account.balance, 1009.937)

    def test_open_short_and_stop_loss(self):
        market = self.init_market()
        account = FuturesAccount(1000, market)
        account.open_order(Side.SELL, 100, 1000, OrderType.MARKET, 1)
        account.open_order(Side.BUY, 90, 1100, OrderType.STOP_LOSS_MARKET, 1)
        self.assertEqual(account.balance, 899.97)
        position = account.get_position()
        self.assertIsNotNone(position)
        self.assertEqual(position.balance(), 100)

        new_price = KLine(900, 1200, 1000, 900, "0")
        account.update_price(new_price)
        self.assertIsNone(account.position)
        self.assertEqual(len(account.order_list), 0)
        self.assertEqual(account.balance, 989.943)

    def test_open_short_and_stop_loss(self):
        account = FuturesAccount(1000, None)

        account.open_order(Side.SELL, 100, 1000, OrderType.MARKET, 1)
        account.open_order(Side.BUY, 90, 1100, OrderType.STOP_LOSS_MARKET, 1)


if __name__ == '__main__':
    unittest.main()
