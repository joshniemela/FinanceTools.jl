export volumebars
export dollarbars

using DataFrames
using RollingFunctions

"""
Calculates volume bars with a constant volume per bar. 
Input is a dataframe in the following order: Time, Price, Volume

Output is a dataframe in the following order: Time, Open, High, Low, Close, Volume

# Keyword arguments
- `method` : chooses the mode used to generate volume bars, "constant" is set by default and "SMA", "EMA" will be implemented later on.
- `threshold` : threshold for the volume accumulator, a new candle will be produced when the cumulative volume exceeds this number. 
- `frequency` : not used
- `windowlen` : not used
"""
function volumebars(
    data::DataFrame;
    method = "constant",
    threshold = nothing,
    frequency = nothing,
    windowlen = 1000,
)
    if method ∉ ["constant"]#, "sma", "ema"] will be added later
        throw(ArgumentError("method must be one of the following: 'constant'"))#, 'sma', 'ema'"))
    end

    if method == "constant"
        candle_n = 0
        last_i = 1
        volumesum = 0
        candles = Matrix{Number}(undef, (6, size(data)[1])) #fix this so it only needs integers, timestmap needs to be converted to float

        times = data[:, :1]
        prices = data[:, :2]
        volumes = data[:, :3]

        for i = 1:size(data)[1]
            volumesum += volumes[i]
            if volumesum > threshold
                candle_n += 1
                candles[:, candle_n] .= times[i],
                prices[last_i],
                maximum(prices[last_i:i]),
                minimum(prices[last_i:i]),
                prices[i],
                volumesum

                volumesum = 0
                last_i = i
            end
        end
        candles = candles[:, 1:candle_n]

        df = DataFrame()
        df.Time = candles[1, :]
        df.Open = candles[2, :]
        df.High = candles[3, :]
        df.Low = candles[4, :]
        df.Close = candles[5, :]
        df.Volume = candles[6, :]
        return (df)
    end

    # NOT FINISHED YET
    """
    if method == "sma"
        candle_n = 0
        last_i = 1
        volumesum = 0
        candles = Matrix{Number}(undef, (6, size(data)[1])) #fix this so it only needs integers, timestmap needs to be converted to float

        times = data[:, :1]
        prices = data[:, :2]
        volumes = data[:, :3]

        volumeavg = rollmean(volumes, windowlen)
        for i = 1:size(data)[1]
            volumesum += volumes[i]
            if volumesum > volumeavg[i]*10
                candle_n += 1
                candles[:, candle_n] .= times[i],
                prices[last_i],
                maximum(prices[last_i:i]),
                minimum(prices[last_i:i]),
                prices[i],
                volumesum

                volumesum = 0
                last_i = i
            end
        end
        candles = candles[:, 1:candle_n]

        df = DataFrame()
        df.Time = candles[1, :]
        df.Open = candles[2, :]
        df.High = candles[3, :]
        df.Low = candles[4, :]
        df.Close = candles[5, :]
        df.Volume = candles[6, :]
        return (df)
        
    end
    """
end


"""
Calculates dollar bars with a constant amount of dollars per bar. 
Input is a dataframe in the following order: Time, Price, Volume

Output is a dataframe in the following order: Time, Open, High, Low, Close, Volume

# Keyword arguments
- `method` : chooses the mode used to generate dollar bars, "constant" is set by default and "SMA", "EMA" will be implemented later on.
- `threshold` : threshold for the dollar accumulator, a new candle will be produced when the cumulative dollar amount exceeds this number. 
- `frequency` : not used
- `windowlen` : not used
"""
function dollarbars(
    data::DataFrame;
    method = "constant",
    threshold = nothing,
    frequency = nothing,
    windowlen = 1000,
)
    if method ∉ ["constant"]#, "sma", "ema"] will be added later
        throw(ArgumentError("method must be one of the following: 'constant'"))#, 'sma', 'ema'"))
    end

    if method == "constant"
        candle_n = 0
        last_i = 1
        dollarsum = 0
        candles = Matrix{Number}(undef, (6, size(data)[1])) #fix this so it only needs integers, timestmap needs to be converted to float

        times = data[:, :1]
        prices = data[:, :2]
        volumes = data[:, :3]

        for i = 1:size(data)[1]
            dollarsum += volumes[i]*prices[i]
            if dollarsum > threshold
                candle_n += 1
                candles[:, candle_n] .= times[i],
                prices[last_i],
                maximum(prices[last_i:i]),
                minimum(prices[last_i:i]),
                prices[i],
                dollarsum

                dollarsum = 0
                last_i = i
            end
        end
        candles = candles[:, 1:candle_n]

        df = DataFrame()
        df.Time = candles[1, :]
        df.Open = candles[2, :]
        df.High = candles[3, :]
        df.Low = candles[4, :]
        df.Close = candles[5, :]
        df.Volume = candles[6, :]
        return (df)
    end
end

