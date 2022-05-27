using Parquet, Plots, DataFrames, MultivariateStats, Dates, FFTW


function fracdiff(x)
    d = 0.01
    #x = x.-x[1]#.-mean(x)# may be needed
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

file = "/home/josh/FinanceTools/MSFT.parquet"
df = DataFrame(read_parquet(file))
dropmissing!(df)
mapcols!(fracdiff, df)

train = df[1:nrow(df)÷2, :]
test =  df[nrow(df)÷2:end, :]


traindata = copy(Matrix(train[!, 2:5])')
testdata = copy(Matrix(test[!, 2:5])')

M = fit(ICA, traindata, 2)

df.date = unix2datetime.(df.datetime/1000)

Y = predict(M, testdata)

plot(Y', layout = (size(Y)[1], 1))
#=
p = plot()
for i in 2:5
    plot!(p, df.date, df[!, i])
end

#for i in 
#plot!(p, df.date[length(Y):end], Y)
display(p)
=#

