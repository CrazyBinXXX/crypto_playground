class BaseConfig:
    TAKER_FEE = None
    MAKER_FEE = None

    @classmethod
    def check(cls):
        for name, value in cls.__dict__.items():
            if name[:2] == "__":
                continue
            print(f"Config: {name} = {value}")
            if value is None:
                assert False, f"ConfigError: {name} is None"


if __name__ == '__main__':
    config = BaseConfig()
    config.check()
