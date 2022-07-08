import unittest

from account.contract_accont import ContractAccount
from simu_market import SimuMarket
import pandas as pd


class TestContractAccount(unittest.TestCase):
    def __init__(self, *args, **kwargs):
        super(TestContractAccount, self).__init__(*args, **kwargs)
        df = pd.DataFrame({'c': [100, 200, 300, 400, 500, 300, 200]})
        self.sm = SimuMarket()
        self.sm.load_df(df)

    def test_open_long(self):
        self.sm.reset_idx()
        account = ContractAccount(self.sm, 10000)
        account.long_underlying('ETH')
        self.assertEqual(account.get_total_asset(), 10000)
        self.assertEqual(account.positions["ETH"]["Long Positions"].amount, 100)
        self.assertEqual(account.trade_num, 1)

    def test_close_long(self):
        self.sm.reset_idx()
        account = ContractAccount(self.sm, 10000)
        account.long_underlying('ETH')
        _ = self.sm.get_next_data()
        account.close_long_position('ETH')
        self.assertEqual(account.get_total_asset(), 20000)
        self.assertEqual(account.positions["ETH"]["Long Positions"].amount, 0)
        self.assertEqual(account.trade_num, 2)
        self.assertEqual(account.trade_history[-1].profit, 10000)

    def test_open_short(self):
        self.sm.reset_idx()
        account = ContractAccount(self.sm, 10000)
        account.short_underlying('ETH')
        self.assertEqual(account.get_total_asset(), 10000)
        self.assertEqual(account.positions["ETH"]["Short Positions"].amount, 100)
        self.assertEqual(account.trade_num, 1)

    def test_close_short(self):
        self.sm.reset_idx()
        account = ContractAccount(self.sm, 10000)
        account.short_underlying('ETH')
        _ = self.sm.get_next_data()
        account.close_short_position('ETH')
        self.assertEqual(account.get_total_asset(), 0)
        self.assertEqual(account.positions["ETH"]["Short Positions"].amount, 0)
        self.assertEqual(account.trade_num, 2)
        self.assertEqual(account.trade_history[-1].profit, -10000)


if __name__ == '__main__':
    unittest.main()