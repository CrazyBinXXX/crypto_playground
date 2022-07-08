import os
import time
from datetime import datetime, timedelta
import sys
from binance.um_futures import UMFutures
import logging
from binance.error import ClientError
import numpy as np

API_KEY = os.environ['BINANCE_API_KEY']
API_SECRET = os.environ['BINANCE_SECRET']

if __name__ == '__main__':
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)
    um_futures_client = UMFutures(key=API_KEY, secret=API_SECRET)
    try:
        response = um_futures_client.change_leverage(
            symbol="BTCBUSD", leverage=1, recvWindow=6000
        )
        logging.info(response)
    except ClientError as error:
        logging.error(
            "Found error. status: {}, error code: {}, error message: {}".format(
                error.status_code, error.error_code, error.error_message
            )
        )

    response = um_futures_client.get_position_mode()

    busd_balance = 0
    try:
        response = um_futures_client.account(recvWindow=6000)
        busd_balance = 0
        for asset in response['assets']:
            if asset['asset'] == 'BUSD':
                busd_balance = float(asset['availableBalance'])
        # logging.info(response)
    except ClientError as error:
        logging.error(
            "Found error. status: {}, error code: {}, error message: {}".format(
                error.status_code, error.error_code, error.error_message
            )
        )

    btc_price = 20000
    max_quant = round((1 * busd_balance / float(btc_price)) / 2, 3)
    try:
        response = um_futures_client.new_order(
            symbol="BTCBUSD",
            side="SELL",
            type="MARKET",
            quantity=max_quant,
            positionSide="short",
        )
        logging.info(response)
    except ClientError as error:
        logging.error(
            "Found error. status: {}, error code: {}, error message: {}".format(
                error.status_code, error.error_code, error.error_message
            )
        )

    time.sleep(1)

    try:
        response = um_futures_client.new_order(
            symbol="BTCBUSD",
            side="BUY",
            type="STOP_MARKET",
            quantity=max_quant,
            stopPrice=round(19254 / (1 - 0.01), 1),
            positionSide="short",
        )
        logging.info(response)
    except ClientError as error:
        logging.error(
            "Found error. status: {}, error code: {}, error message: {}".format(
                error.status_code, error.error_code, error.error_message
            )
        )

    try:
        response = um_futures_client.new_order(
            symbol="BTCBUSD",
            side="BUY",
            type="TAKE_PROFIT_MARKET",
            quantity=max_quant,
            stopPrice=round(19254 / (1 + 0.02), 1),
            positionSide="short",
        )
        logging.info(response)
    except ClientError as error:
        logging.error(
            "Found error. status: {}, error code: {}, error message: {}".format(
                error.status_code, error.error_code, error.error_message
            )
        )