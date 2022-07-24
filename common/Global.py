from DataLog.CsvDataLog import CsvDataLog
from common.BorisConfig import BorisConfig

Config = BorisConfig
DATALOG = CsvDataLog("./data/position.csv", "./data/order.csv")

Config.check()
