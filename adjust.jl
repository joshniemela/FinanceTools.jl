using Parquet, DataFrames, BenchmarkTools

path = "/media/sshfs/stockdata/juliadollarbars/"
file = "MSFT.parquet"

df = DataFrame(read_parquet(path*file))

function split_adjust(df)
    close = df.close
    shifted = circshift(close, 1)
    cumratio = cumprod(div.(shifted, close, RoundNearest))

    df.close = df.close .* cumratio
    df.high = df.high .* cumratio
    df.low = df.low .* cumratio
    df.open = df.open .* cumratio
    df.volume = df.volume ./ cumratio

    return df
end

@btime split_adjust($df);