module FinanceTools
import DataFrames: DataFrame

include("fracdiff.jl")
export fracdiff, fracdiff!

include("labelling.jl")
export trendlabel

function split_adjust(df::DataFrame)
    close = copy(df.close)
    shifted = circshift(close, 1)
    cumratio = cumprod(div.(shifted, close, RoundNearest)) # checks if the stock has changed more than 50% in 1 minute.

    df.close = df.close .* cumratio
    df.high = df.high .* cumratio
    df.low = df.low .* cumratio
    df.open = df.open .* cumratio
    df.volume = df.volume ./ cumratio

    return df
end
export split_adjust

end # module
