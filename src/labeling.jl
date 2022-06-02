"""
Implements continuous trend labeling according to "A Labeling Method for Financial Time Series
Prediction Based on Trends" 
by Dingming Wu, Xiaolong Wang *, Jingyong Su, Buzhou Tang and Shaocong Wu"
link : https://pdfs.semanticscholar.org/9ab2/13b22d49099256b1c98e476be2022922e8f6.pdf

Code will be optimised later on
"""

function trendlabel(x::AbstractArray, ω::Real)
    N = length(x) # paper uses N as length of vector
    t = collect(1:N) # paper uses this thing for some reason
    y = zeros(Int8, N) # initialise array containing labels
    #initialising stuff
    FP = x[1] # first price
    xₕ = x[1] # highest price as of yet
    xₗ = x[1] #lowest price as of yet
    HT = t[1] #time highest price was reached
    LT = t[1] #time the lowest price was reached
    Cid = 0 #direction of trend
    FP_N = 0 # index of first price for loop
    #alg starts here
    for i in 1:N
        if x[i] > FP + x[1] * ω
            xₕ, HT, FP_N, Cid = x[i], t[i], i, 1
            break
        end
        if x[i] < FP - x[1] * ω
            xₗ, LT, FP_N, Cid = x[i], t[i], i, -1
            break
        end
    end

    for i in FP_N+1:N
        # Trending down
        if Cid > 0
            if x[i] > xₕ
                xₕ, HT = x[i], t[i]
            end
            if x[i] < xₕ - xₕ * ω && LT ≤ HT
                for j in 1:N
                    if t[j] > LT && t[j] ≤ HT
                        y[j] = 1
                    end
                end
                xₗ, LT, Cid = x[i], t[i], -1
            end
        end
        # Trending up
        if Cid < 0
            if x[i] < xₗ
                xₗ, LT = x[i], t[i]
            end
            if x[i] > xₗ + xₗ * ω && HT ≤ LT
                for j in 1:N
                    if t[j] > HT && t[j] ≤ LT
                        y[j] = -1
                    end
                end
                xₕ, HT, Cid = x[i], t[i], 1
            end
        end
    end
    return (y)
end
export trendlabel