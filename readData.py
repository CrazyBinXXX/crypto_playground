import numpy as np

def getNMA(arr : np.array, n : int):
    # n must > len(arr)
    s = sum(arr[:n])
    ret = [e for e in arr[:n-1]] + [s/n]
    for i in range(n, len(arr)):
        s -= arr[i - n]
        s += arr[i]
        ret = np.append(ret, s/n)
    return np.array(ret)

if __name__ == "__main__":
    # df = pd.read_csv("./dataHouse/ETHUSDT_2021-09-01-2021-09-30_1m.csv")
    # print(df)
    # print(np.array(df['c']))
    print(getNMA(np.array([1,2,3,4,5,6,7,8,9,10]), 5))