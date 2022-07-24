import unittest

from account.Account import FuturesAccount
from common.KLine import KLine
from markets.FuturesOrder import OrderType
from markets.Side import Side


class OrderTestClass(unittest.TestCase):
    def test_open_long_and_take_profit(self):
        account = FuturesAccount(1000, None)
        account.open_order(Side.BUY, 100, 1000, OrderType.MARKET_BUY, 1)
        account.open_order(Side.SELL, 110, 1100, OrderType.TAKE_PROFIT_MARKET, 1)

        self.assertEqual(account.balance, 899.97)
        position = account.get_position()
        self.assertIsNotNone(position)
        self.assertEqual(position.balance(), 100)

        new_price = KLine(900, 1200, 1000, 1100, "0")
        account.update_price(new_price)
        self.assertIsNone(account.position)
        self.assertEqual(len(account.order_list), 0)
        self.assertEqual(account.balance, 1009.937)

    def test_open_long_and_stop_loss(self):
        account = FuturesAccount(1000, None)
        account.open_order(Side.BUY, 100, 1000, OrderType.MARKET_BUY, 1)
        account.open_order(Side.SELL, 90, 900, OrderType.STOP_LOSS_MARKET, 1)

        self.assertEqual(account.balance, 899.97)
        position = account.get_position()
        self.assertIsNotNone(position)
        self.assertEqual(position.balance(), 100)

        new_price = KLine(900, 1200, 1000, 1100, "0")
        account.update_price(new_price)
        self.assertIsNone(account.position)
        self.assertEqual(len(account.order_list), 0)
        self.assertEqual(account.balance, 989.943)


if __name__ == '__main__':
    unittest.main()
