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

function fracdiff(data::AbstractArray, d::Number, cutoff::Number=1e-3)
    conv(data, weights(d, cutoff))[1:length(data)]
end

function fracdiff!(data::AbstractArray, d::Number, cutoff::Number=1e-3)
    data .= conv(data, weights(d, cutoff))[1:length(data)]
end
 