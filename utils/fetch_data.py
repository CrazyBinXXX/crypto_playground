from datetime import datetime, timedelta

import pandas as pd
from binance.um_futures import UMFutures


def fetch_simple(client, symbol, lim=1, minutes_interval=15):
    response = client.klines(symbol, '15m', **{"limit": lim})
    columns = ['open_time',
               'o', 'h', 'l', 'c', 'v',
               'close_time', 'qav', 'num_trades',
               'taker_base_vol', 'taker_quote_vol', 'ignore']
    response_df = pd.DataFrame.from_records(response, columns=columns)
    return response_df


def fetch_large(client, symbol, lim, times, minutes_interval=15):
    now = datetime.now()
    nearest_min = now.replace(microsecond=0, second=0).replace(
        minute=((int(now.minute) // minutes_interval) * minutes_interval))
    starts = []
    for i in range(times):
        starts.append(nearest_min - timedelta(minutes=lim * minutes_interval * (times - i)))

    # rencent_prices
    columns = ['open_time',
               'o', 'h', 'l', 'c', 'v',
               'close_time', 'qav', 'num_trades',
               'taker_base_vol', 'taker_quote_vol', 'ignore']
    recent_prices_df = pd.DataFrame(columns=columns)
    for idx, t in enumerate(starts):
        response = client.klines(symbol, f'{minutes_interval}m', **{"limit": lim, 'startTime': 1000 * int(
            datetime.timestamp(t))})
        response_df = pd.DataFrame.from_records(response, columns=columns)
        recent_prices_df = pd.concat([recent_prices_df, response_df], ignore_index=True)
        print(f"{idx}, {len(starts)}", end="\r")

    return recent_prices_df


# TEST PART
if __name__ == '__main__':
    um_futures_client = UMFutures(key=None, secret=None, base_url="https://fapi.binance.com")
    recent_prices = fetch_large(um_futures_client, 'BTCBUSD', 500, 60 * 24 * 365 // 500, 1)
    recent_prices.to_csv("/Users/borischen/PycharmProjects/crypto_backtest/data/last_500min.csv", index=False)
