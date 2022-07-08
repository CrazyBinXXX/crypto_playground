import time
from datetime import datetime, timedelta
import sys
from binance.um_futures import UMFutures
import logging
from binance.error import ClientError
import numpy as np


class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'


class Trader:
    def __init__(self, um_futures_client, logger):
        self.um_futures_client = um_futures_client
        self.logger = logger
        self.recent200_prices = []
        self.recent200_prices_len = 0
        self.recent2000_prices = []
        self.recent2000_prices_len = 0
        self.wait_count = 10

        # Factors
        self.bolling_m = -1
        self.bolling_2u = -1
        self.std = -1
        self.volatility = -1
        self.base_vol = -1
        self.trendEMA = -1



    def run(self):
        while True:
            data = self.fetch_mark_price()
            self.process_price(data)
            logger.info('Process finish time: ' + datetime.now().strftime("%Y/%m/%d, %H:%M:%S:%f"))

            if self.wait_count == 0:
                # Trade decision
                short_signal = self.open_short_signal(float(data[0][1]), float(data[0][4]))
                if short_signal:
                    print(bcolors.WARNING + "SHORT!!!" + bcolors.ENDC)
                else:
                    print(bcolors.OKGREEN + "Another peace day." + bcolors.ENDC)

            # Post process
            if self.wait_count > 0:
                self.wait_count -= 1
            now = datetime.now()
            next_run = now + timedelta(minutes=1)
            next_run = next_run.replace(microsecond=0, second=0)
            delay = (next_run - now)
            time.sleep(delay.total_seconds())

    def process_price(self, data):
        self.recent200_prices.append(float(data[0][4]))
        self.recent200_prices_len += 1
        self.recent2000_prices.append(float(data[0][4]))
        self.recent2000_prices_len += 1
        if self.recent200_prices_len > 200:
            self.recent200_prices.pop(0)
            self.recent200_prices_len -= 1
        if self.recent2000_prices_len > 2000:
            self.recent2000_prices.pop(0)
            self.recent2000_prices_len -= 1

        logger.info(self.recent200_prices)
        logger.info(self.recent2000_prices)
        self.calc_indicators()

    def calc_indicators(self):
        copy_recent_200 = np.array(self.recent200_prices)
        copy_recent_2000 = np.array(self.recent2000_prices)
        self.bolling_m = copy_recent_200.mean()
        self.std = copy_recent_200.std()
        self.bolling_2u = self.bolling_m + 2 * self.std
        self.volatility = 4 * self.std
        self.base_vol = copy_recent_2000.mean()
        self.ema_update(copy_recent_200[-1], 1500)
        print(self.bolling_m)
        print(self.bolling_2u)
        print(self.trendEMA)

    def fetch_mark_price(self):
        try:
            response = um_futures_client.mark_price_klines('BTCBUSD', '1m', **{"limit": 1})
            logger.info('Fetch finish time: ' + datetime.now().strftime("%Y/%m/%d, %H:%M:%S:%f"))
            logger.info(response)
            return response
        except ClientError as error:
            logger.error(
                "Found error. status: {}, error code: {}, error message: {}".format(
                    error.status_code, error.error_code, error.error_message
                )
            )

    def ema_update(self, newPrice, days, smoothing=2):
        if self.trendEMA == -1:
            self.trendEMA = newPrice
        else:
            ratio = (smoothing / (1 + days))
            self.trendEMA = newPrice * ratio + self.trendEMA * (1 - ratio)

    def open_short_signal(self, o, c):
        cross_bolling_m_flag = (o > self.bolling_m > c) or (o > self.bolling_2u > c)
        trend_bear_flag = c < self.trendEMA
        low_vol_flag = self.volatility < 1.5 * self.base_vol
        print(cross_bolling_m_flag, trend_bear_flag, low_vol_flag)
        return cross_bolling_m_flag and trend_bear_flag and low_vol_flag



if __name__ == '__main__':
    um_futures_client = UMFutures(key=API_KEY, secret=API_SECRET)
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)
    logger = logging.getLogger()
    trader = Trader(um_futures_client, logger)
    trader.run()