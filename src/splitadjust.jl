export split_adjust
export split_adjust!

using DataFrames

"""
Function rolls over a dataframe comprised of OHCLV data and finds sudden jumps in the stock price of over 50% and assumes it to be a stock split / merge that has to be corrected.
"""
function split_adjust(df::DataFrame)
    close = copy(df.close)
    shifted = circshift(close, 1)
    cumratio = cumprod(div.(shifted, close, RoundNearest)) # checks if the stock has changed more than 50% in 1 minute.

    df.Close = df.Close .* cumratio
    df.High = df.High .* cumratio
    df.Low = df.Low .* cumratio
    df.Open = df.Open .* cumratio
    df.Volume = df.Volume ./ cumratio

    return df
end
"""
Inplace version of split_adjust
"""
function split_adjust!(df::DataFrame)
    close = copy(df.close)
    shifted = circshift(close, 1)
    cumratio = cumprod(div.(shifted, close, RoundNearest)) # checks if the stock has changed more than 50% in 1 minute.

    df.Close = df.Close .* cumratio
    df.High = df.High .* cumratio
    df.Low = df.Low .* cumratio
    df.Open = dfOpen .* cumratio
    df.Volume = df.Volume ./ cumratio
end