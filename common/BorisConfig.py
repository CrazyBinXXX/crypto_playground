from common.BaseConfig import BaseConfig


class BorisConfig(BaseConfig):
    MAKER_FEE = 0.012 * 0.01
    TAKER_FEE = 0.021 * 0.01


if __name__ == '__main__':
    config = BorisConfig()
    config.check()
