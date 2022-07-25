from backtestGround.utils import get_data
import pandas as pd
from numpy_ext import rolling_apply
import numpy as np
import math
import  tensorflow as tf
import tensorflow_decision_forests as tfdf


def label_alphas(input_df, long_model, short_model):
    alpha_cols = ['vol_too_high', 'trend_bull', 'trend_bear', '10_c_log_return',
                  '30_c_log_return', '60_c_log_return', '10_c_bull', '30_c_bull',
                  '60_c_bull', 'bolling_bull', 'bolling_bear', 'o_relative', 'h_relative',
                  'l_relative', 'c_relative', 'v_relative', 'long_signal', 'short_signal',
                  'alpha_6', 'alpha_12']
    alpha_df = input_df[alpha_cols] * 1
    alphas_ds = tfdf.keras.pd_dataframe_to_tf_dataset(alpha_df)
    long_model_results = long_model.predict(alphas_ds)
    short_model_results = short_model.predict(alphas_ds)
    print(input_df.shape)
    print(long_model_results.shape)
    print(short_model_results.shape)
    print(long_model_results)
    print(short_model_results)
    input_df['long_score'] = long_model_results
    input_df['short_score'] = short_model_results
    input_df.to_csv('BTCUSDT_2017-07-10-2022-07-10_15m_learning_prepared_v1.0_predicted.csv')


if __name__ == '__main__':
    intervals1 = ['2017-07-10', '2022-07-10']
    data, extended_data = get_data('BTCUSDT', intervals1[0], intervals1[1], '15m', True, 'learning_prepared_v0.6')
    long_model_path = "../modelHouse/rf_long_model_v0.7_5min"
    rf_long_model = tf.keras.models.load_model(long_model_path)
    short_model_path = "../modelHouse/rf_short_model_v0.7_5min"
    rf_short_model = tf.keras.models.load_model(short_model_path)
    cautiousness = 0.55
    label_alphas(extended_data, rf_long_model, rf_short_model)

