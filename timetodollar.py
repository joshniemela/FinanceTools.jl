import pandas as pd
import time
import re
import os
import numpy as np
import matplotlib.pyplot as plt
import mplfinance as mpf
#import yfinance as yf
path = "/media/sshfs/stockdata/juliadollarbars/"
df=pd.read_parquet(path+"MSFT.parquet")
#df=yf.Ticker("AMD").history(period="6mo")
print(df)
#fig,(ax1,ax2)=plt.subplots(2)
df.index = pd.to_datetime(df["datetime"], unit="s")
#mpf.plot(df, type="candle",style="charles", volume=True)

fig,(ax1,ax2,ax3)=plt.subplots(3)
def dollarbars(timebars,threshold):
    volume=timebars["volume"].values
    volumesum=np.cumsum(volume)
    volumesum=volumesum%threshold
    volumediff=np.diff(volumesum)
    volumediff=volumediff*-1
    volumediff=np.heaviside(volumediff,1)
    
    volumediff=np.where(volumediff==1)
    newdf=timebars.iloc[volumediff]
    newdf["open"]=newdf["close"].shift(1)
    newdf=newdf.dropna()
    #return(newdf)

start = time.perf_counter_ns()
for i in range(1):
    k=dollarbars(df, 500000)
print((time.perf_counter_ns()-start))



#mpf.plot(df,ax=ax1,type="candle",volume=ax3, style="charles",show_nontrading=True)
#mpf.plot(k,ax=ax2,type="candle",style="charles",show_nontrading=True)

#mpf.show()