# performance metrics
# performance metric functions using returns as input argument

import numpy as np
import matplotlib.pyplot as plt

# compute the path (growth) of investment using rets
def path(rets):
    rets_copy = [ret for ret in rets]
    rets_copy[0] += 1
    for i in range(1, len(rets_copy)):
        rets_copy[i] = rets_copy[i-1] * (1+rets_copy[i])
    return rets_copy

# plot the path (growth) of investment using rets
def plot_path(rets):
    wealth = path(rets)
    plt.plot(wealth)
    plt.show()

# cumulative return
def cumul_ret(rets) -> float:
    rets = [ret + 1 for ret in rets]
    return np.prod(rets) - 1.0

# stdev considering only negative returns
def downside_risk(rets) -> float:
    rets = [ret for ret in rets if ret < 0.0]
    if not rets:
        raise Exception("No downside risk.")
    return np.std(rets) 

# calculate annualized sharpe ratio, need # of mintute as frequency input
def sharpe(rets, minute_freq, rf:float = 0.0, downside:bool = False, trading_days:int = 365) -> float:
    scalar = trading_days * 24.0 * 60.0 / minute_freq # used for annualizing
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

