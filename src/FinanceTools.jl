module FinanceTools

function split_adjust(df::AbstractArray)
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
export split_adjust
end # module
