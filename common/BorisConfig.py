from BaseConfig import BaseConfig


class BorisConfig(BaseConfig):
    MAKER_FEE = 0.02
    TAKER_FEE = 0.03


if __name__ == '__main__':
    config = BorisConfig()
    config.check()
