export fracdiff, fracdiff!
using DSP
function weights(d::Number, cutoff::Number)
    if d < 0
        throw(DomainError("d=$d", "fracdiff operator only defined for range d = [0,∞]"))
    end
    ω = Float64[1]
    k = 1
    while cutoff < abs(last(ω))
        push!(ω, -last(ω) * (d - k + 1) / k)
        k += 1
    end
    return (ω)
end
    
"""
Calculates the fractional difference of a vector of numbers.
# Keyword arguments
- `d` : Order of difference, applies the n'th order of fractional difference to the series. Integer orders result in the same as the lag operator.
- `cutoff` : The minimum value of a term in the binomial weights, lower values will result in a more precise result with a higher computatinal cost.
"""
function fracdiff(data::AbstractArray, d::Number, cutoff::Number=1e-3)
    conv(data, weights(d, cutoff))[1:length(data)]
end

"""
Inplace version of the fracdiff function.
    
Calculates the fractional difference of a vector of numbers.
# Keyword arguments
- `d` : Order of difference, applies the n'th order of fractional difference to the series. Integer orders result in the same as the lag operator.
- `cutoff` : The minimum value of a term in the binomial weights, lower values will result in a more precise result with a higher computatinal cost.
"""    
function fracdiff!(data::AbstractArray, d::Number, cutoff::Number=1e-3)
    data .= conv(data, weights(d, cutoff))[1:length(data)]
end
 
