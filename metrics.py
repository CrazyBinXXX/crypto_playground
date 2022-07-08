# performance metrics

import numpy as np
import matplotlib.pyplot as plt

# compute the path (growth) of investment using rets
def path(rets):
    rets_copy = rets.copy()
    rets_copy[0] += 1.0
    for i in range(1, len(rets_copy)):
        rets_copy[i] = rets_copy[i-1] * (1+rets_copy[i])
    return rets_copy

# plot the path (growth) of investment using rets
def plot_path(rets):
    wealth = [value for value in path(rets)]
    plt.plot(wealth)
    plt.xticks(ticks=range(len(wealth))[::len(wealth)//2-1], labels = rets.index.values[::len(rets)//2-1])
    plt.show()

# cumulative return
def cumul_ret(rets) -> float:
    rets = [ret + 1 for ret in rets]
    return np.prod(rets) - 1.0

# annualized return
def annual_ret(rets, minute_freq, trading_days:int = 365) -> float:
    scalar = trading_days * 24.0 * 60.0 / minute_freq # used for annualizing
    return (1.0 + cumul_ret(rets)) ** (scalar / len(rets)) - 1.0

# stdev considering only negative returns
def downside_risk(rets) -> float:
    rets = [ret for ret in rets if ret < 0.0]
    if not rets:
        raise Exception("No downside risk.")
    return np.std(rets) 

# calculate annualized sharpe ratio, need # of mintute as frequency input
def sharpe(rets, minute_freq, rf:float = 0.0, downside:bool = False, trading_days:int = 365) -> float:
    scalar = trading_days * 24.0 * 60 / minute_freq # used for annualizing
    if downside:
        return (np.mean(rets) - rf) / downside_risk(rets) * np.sqrt(scalar)
    return (np.mean(rets) - rf) / np.std(rets) * np.sqrt(scalar)

def max_drawdown(rets):
    rets = [np.log(ret+1.0) for ret in rets]
    currentSum, maxDrawdown= rets[0], rets[0]
    for i in range(1, len(rets)):
        currentSum = min(rets[i], rets[i] + currentSum)
        maxDrawdown = min(maxDrawdown, currentSum)
    return np.exp(maxDrawdown) - 1.0

def calc_cubic_interpolation(x):
    n = len(x) - 1
    M = np.zeros(4*n, 4*n)
    M[0, 2] = 2
    M[0, 3] = 6*x[0]
    M[4*n-1, 4*n-2] = 2
    M[4*n-1, 4*n-1] = 6*x[n]
    for i in range(1, n+1):
        M[4*i-3, 4*i-4] = 1
        M[4*i-3, 4*i-3] = x[i-1]
        M[4*i-3, 4*i-2] = x[i-1]**2
        M[4*i-3, 4*i-1] = x[i-1]**3

        M[4 * i - 2, 4 * i - 4] = 1
        M[4 * i - 2, 4 * i - 3] = x[i]
        M[4 * i - 2, 4 * i - 2] = x[i] ** 2
        M[4 * i - 2, 4 * i - 1] = x[i] ** 3

        if i != n:
            M[4 * i - 1, 4 * i - 3] = 1
            M[4 * i - 1, 4 * i - 2] = 2 * x[i]
            M[4 * i - 1, 4 * i - 1] = 3 * x[i] ** 2
            M[4 * i - 1, 4 * i + 1] = -1
            M[4 * i - 1, 4 * i + 2] = -2*x[i]
            M[4 * i - 1, 4 * i + 3] = -3* x[i]**2

            M[4 * i - 1, 4 * i - 2] = 2
            M[4 * i - 1, 4 * i - 1] = 6 * x[i]
            M[4 * i - 1, 4 * i + 2] = -2
            M[4 * i - 1, 4 * i + 3] = -6*x[i]
        return M