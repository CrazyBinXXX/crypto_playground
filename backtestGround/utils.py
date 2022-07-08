import numpy as np
from constants import ROOT_PATH
import pandas as pd


def get_data(symbol: str, start_date: str, end_date: str, interval: str, need_prepared=False, prepare_suffix='', extend_call_back=None):
    path_format = f"/dataHouse/data/cryptoPrices/{symbol}_{start_date}-{end_date}_{interval}.csv"
    data_path = ROOT_PATH + path_format
    try:
        data = pd.read_csv(data_path, index_col=0)
    except FileNotFoundError:
        return None
    if need_prepared:
        prepared_path_format = f"/dataHouse/data/cryptoPrices/{symbol}_{start_date}-{end_date}_{interval}_{prepare_suffix}.csv"
        prepared_data_path = ROOT_PATH + prepared_path_format
        try:
            prepared_data = pd.read_csv(prepared_data_path, index_col=0)
        except FileNotFoundError:
            prepared_data = extend_call_back(data)
            prepared_data.to_csv(prepared_data_path)
            prepared_data = pd.read_csv(prepared_data_path, index_col=0)
        return data, prepared_data
    return data


def tangency_portfolio(underlying_price, hist_asset):
    X = np.stack((underlying_price, hist_asset), axis=0)
    sigma = np.cov(X)
    miu = np.array([underlying_price[-1] / underlying_price[0] - 1, hist_asset[-1] / hist_asset[0] - 1])
    x = np.linalg.solve(sigma, miu)
    w = 1 / (x.sum()) * x
    return w