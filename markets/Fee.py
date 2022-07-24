class Fee:
    def __init__(self, maker, taker):
        assert(maker is not None)
        assert(taker is not None)

        self.maker = maker
        self.taker = taker
