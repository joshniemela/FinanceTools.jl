module FinanceTools
import DataFrames: DataFrame
import FFTW: fft, ifft

export split_adjust
export fracdiff

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

function fracdiff(x::AbstractVector, d::Real)
    T = length(x)
    np₂ = Int(2^ceil(log2(2T-1)))
    k = 1:(T-1)
    b = cumprod((k.-(d).-1)./k)
    pushfirst!(b, 1)
    z = zeros(np₂-T)
    pushfirst!(z, 0)
    z₁ = vcat(b, z)
    z₂ = vcat(x, z)
    dx = ifft(fft(z₁).*fft(z₂))
    return real(getindex(dx, 1:T))
end

end # module
