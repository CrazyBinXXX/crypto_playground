import sys

from binance.cm_futures import CMFutures
from binance.um_futures import UMFutures
import logging
from binance.error import ClientError

if __name__ == '__main__':
    um_futures_client = UMFutures(key=API_KEY, secret=API_SECRET)
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)
    logger = logging.getLogger()
    try:
        response = um_futures_client.account(recvWindow=6000)
        logger.info(response)
    except ClientError as error:
        logger.error(
            "Found error. status: {}, error code: {}, error message: {}".format(
                error.status_code, error.error_code, error.error_message
            )
        )

