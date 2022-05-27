import pandas as pd
import numpy as np
import timeit
def split_adjust(df):
    openarr=df["open"].values
    ratio=np.round(np.roll(openarr,1)/openarr)
    cumratio=ratio.cumprod()
    df["open"]=openarr*cumratio
    df["high"]=df["high"]*cumratio
    df["low"]=df["low"]*cumratio
    df["close"]=df["close"]*cumratio
    df["volume"]=df["volume"]/cumratio
    return df


path = "/media/sshfs/stockdata/juliadollarbars/"
file = "MSFT.parquet"

df = pd.read_parquet(path+file)

num_runs = 250

sum_time = timeit.Timer(lambda: split_adjust(df)).timeit(number = num_runs)

avg = sum_time/num_runs

print(f"It takes on average {avg} seconds to run this")