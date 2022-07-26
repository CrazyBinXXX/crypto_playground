class KLine:
    def __init__(self, l, h, o, c, t):
        self.low = l
        self.high = h
        self.open = o
        self.close = c
        self.timestamp = t
        self.data = None

    def set_data(self, data):
        self.data = data
