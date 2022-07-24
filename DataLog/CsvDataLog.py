import pandas as pd


class CsvDataLog:
    def __init__(self, position_path, order_path):
        self.position_data = []
        self.position_path = position_path
        self.order_data = []
        self.order_path = order_path
        self.idx = 0

    def add_position(self, metrics):
        self.position_data.append(metrics)
        self.idx += 1

        if self.idx % 100 == 0:
            self.close()

    def add_order(self, order):
        self.order_data.append(order)
        self.idx += 1
        if self.idx % 100 == 0:
            self.close()

    def close(self):
        pd.DataFrame(self.position_data).to_csv(self.position_path)
        pd.DataFrame(self.order_data).to_csv(self.order_path)
