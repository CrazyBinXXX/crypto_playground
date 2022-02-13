import requests  # for making http requests to binance
import json  # for parsing what binance sends back to us
import pandas as pd  # for storing and manipulating the data we get back
import numpy as np  # numerical python, i usually need this somewhere
import matplotlib.pyplot as plt  # for charts and such
import datetime as dt  # for dealing with times
import time

root_url = 'https://api.binance.com/api/v1/klines'
symbol = 'ETHUSDT'
interval = '1m'


def fetchHistPrices(symbol, interval, start_timestamp, limit=500):
    url = root_url + '?symbol=' + symbol + '&interval=' + interval + '&startTime=' + str(start_timestamp) + '&limit=' + str(limit)
    data = json.loads(requests.get(url).text)
    df = pd.DataFrame(data)
    df.columns = ['open_time',
                  'o', 'h', 'l', 'c', 'v',
                  'close_time', 'qav', 'num_trades',
                  'taker_base_vol', 'taker_quote_vol', 'ignore']
    df.index = [dt.datetime.fromtimestamp(x / 1000.0) for x in df.close_time]
    return df

def fetchHistPricesOneMinOneDay(symbol, start_date : dt.datetime):
  start_timestamp = int(time.mktime(start_date.timetuple()) * 1000)
  interval_timestamp = 60 * 1000
  result_df = None
  # fetch 4 times
  for i in range(24 * 60 // 360):
    ret_df = fetchHistPrices(symbol, '1m', start_timestamp + i * interval_timestamp * 360, limit=360)
    if i == 0:
      result_df = ret_df
    else:
      result_df = pd.concat([result_df, ret_df])
  return result_df

def fetchHistPriceOneMinPeriod(symbol, start_date : dt.datetime, end_date : dt.datetime):
  cur_date = start_date
  result_df = None
  init = False
  while cur_date < end_date:
    ret_df = fetchHistPricesOneMinOneDay(symbol, cur_date)
    if not init:
      result_df = ret_df
      init = True
    else:
      result_df = pd.concat([result_df, ret_df])

    cur_date += dt.timedelta(days=1)
  return result_df

def strToDate(date_str):
  return dt.datetime.strptime(date_str, "%Y-%m-%d")

if __name__ == "__main__":
    start_date = strToDate("2021-06-01")
    end_date = strToDate("2021-12-31")
    ethusdt = fetchHistPriceOneMinPeriod(symbol, start_date, end_date)
    ethusdt.to_csv("dataHouse/{0}_{1}-{2}_{3}.csv".format(symbol, start_date, end_date, "1m"))
