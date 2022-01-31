"""
This module will generate the Report based on trading data.
It contains metrics which reflect the performance of trading
and functions for stats calc.
"""
from scipy.stats import linregress


class SimuReport:
    """
    This class contains trading stats metics & functions to calc.
    """
    def __init__(self, data_arr):
        self.roi = 0
        self.curve_slope = 0
        self.correlation_coefficient = 0
        self.std_err = 0
        self.volatility = 0
        self.sharp_ratio = 0
        self.max_dropdown = 0

        self.roi = data_arr[-1] / data_arr[0] - 1
        self.curve_slope, _, self.correlation_coefficient, _, self.std_err \
            = linregress(range(0, len(data_arr)), data_arr)
        self.volatility = 1 - self.correlation_coefficient ** 2
        self.sharp_ratio = self.roi / self.volatility
        self.max_dropdown = SimuReport.calc_max_dropdown(data_arr)

    def pretty_print(self):
        print("=====================SCORE BOARD=====================")
        print("Return of Investment: {}%".format(self.number2percentage(self.roi)))
        print("Correlation Coefficient: {}".format(self.correlation_coefficient))
        print("Volatility: {}%".format(self.number2percentage(self.volatility)))
        print("Sharp Ratio: {}".format(self.sharp_ratio))
        print("Max Dropdown: {}%".format(self.number2percentage(self.max_dropdown)))
        print("=========================END=========================")

    @staticmethod
    def number2percentage(num):
        """
        Convert 0.xxxxx to xx.xx.
        :param num:
        :return:
        """
        return round(num * 100, 2)

    @staticmethod
    def calc_max_dropdown(data_arr):
        """
        Calc the max dropdown. (In number min / max)
        :param data_arr:
        :return: The max dropdown
        """
        cur_min = data_arr[-1]
        cur_ret = 1
        for i in range(len(data_arr) - 1, -1, -1):
            if data_arr[i] < cur_min:
                cur_min = data_arr[i]
            else:
                cur_ret = min(cur_ret, cur_min / data_arr[i])
        return 1 - cur_ret
