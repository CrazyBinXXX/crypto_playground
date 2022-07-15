import logging
import os

from binance.error import ClientError
from binance.lib.utils import config_logging
from binance.spot import Spot as Client
import pprint

key = os.environ['BINANCE_API_KEY']
secret = os.environ['BINANCE_SECRET']
spot_client = Client(key, secret)
UNKNOWN_COIN = "UNKNOWN_COIN_ERROR"

# Return the remaining amount of the coin in regular trading account
def get_account_free_asset(coinType="BTC"):
    response = spot_client.account()
    for asset_elem in response['balances']:
        if asset_elem['assets'] == coinType:
            return asset_elem['free']
    return UNKNOWN_COIN

if __name__ == "__main__":
    # params = {
    #     "symbol": "ETHUSDT",
    #     "side": "BUY",
    #     "type": "LIMIT",
    #     "timeInForce": "GTC",
    #     "quantity": 0.01,
    #     "price": 4000,
    # }
    #
    # try:
    #     response = spot_client.new_order(**params)
    #     logging.info(response)
    # except ClientError as error:
    #     logging.error(
    #         "Found error. status: {}, error code: {}, error message: {}".format(
    #             error.status_code, error.error_code, error.error_message
    #         )
    #     )
    #
    pprint.pprint(spot_client.cancel_open_orders("ETHUSDT"))