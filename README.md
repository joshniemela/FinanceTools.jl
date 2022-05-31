# Finance Tools

This is a package for Julia that provides various functions for processing financial time series data.

View on [JuliaHub](https://juliahub.com/ui/Packages/FinanceTools/barsj), or [Julia Packages](https://juliapackages.com/p/financetools).

## Documentation

Package contains various different tools to preprocess time series for machine learning and other uses.

<hr>

<pre><a href="https://dataframes.juliadata.org/stable/lib/types/#DataFrames.DataFrame">DataFrames.DataFrame</a> split_adjust( <a href="https://dataframes.juliadata.org/stable/lib/types/#DataFrames.DataFrame">DataFrames.DataFrame</a> df )</pre>

#### Description

Adjusts dataframes containing stock prices and volume if prices are unadjusted after potential stock merges/splits.

The source code for this function is in [FinanceTools.jl](/src/FinanceTools.jl#L8-L20).

#### Arguments

1. <code><a href="https://dataframes.juliadata.org/stable/lib/types/#DataFrames.DataFrame">DataFrames.DataFrame</a> df</code> *To be filled out.*

#### Returns

1. <code><a href="https://dataframes.juliadata.org/stable/lib/types/#DataFrames.DataFrame">DataFrames.DataFrame</a> df</code> *To be filled out.*

#### Example

```julia
julia> split_adjust()

# This results in...
```

<hr>

<pre>fracdiff( <a href="https://docs.julialang.org/en/v1/base/arrays/#Core.AbstractArray">Core.AbstractArray</a> data, <a href="https://docs.julialang.org/en/v1/base/numbers/#Core.Number">Core.Number</a> d, <a href="https://docs.julialang.org/en/v1/base/numbers/#Core.Number">Core.Number</a> cutoff = 1e-3 )</pre>

#### Description

Calculates the fractional difference of a time series

The source code for this function is in [fracdiff.jl](/src/fracdiff.jl#L16-L18).

#### Arguments

1. <code><a href="https://docs.julialang.org/en/v1/base/arrays/#Core.AbstractArray">Core.AbstractArray</a> data</code> Vector containing series to be differenced.
2. <code><a href="https://docs.julialang.org/en/v1/base/numbers/#Core.Number">Core.Number</a> d</code> Order of diffentiation, can be any positive real number.
3. <code><a href="https://docs.julialang.org/en/v1/base/numbers/#Core.Number">Core.Number</a> cutoff</code> Cutoff value for the binomial weights. Defaults to `1e-3`

#### Returns

This function returns a vector with the same shape as input, efter being differenced.

#### Example

```julia
julia> fracdiff([0.:10.;], 0.5)

# This results in...
11-element Vector{Float64}:
 -4.1236855200362954e-16
  1.0000000000000002
  1.5
  1.8750000000000002
  2.1874999999999996
  2.4609375
  2.707031249999998
  2.9326171874999987
  3.1420898437499987
  3.3384704589843737
  3.523941040039061
```

<hr>

<pre>fracdiff!( <a href="https://docs.julialang.org/en/v1/base/arrays/#Core.AbstractArray">Core.AbstractArray</a> data, <a href="https://docs.julialang.org/en/v1/base/numbers/#Core.Number">Core.Number</a> d, <a href="https://docs.julialang.org/en/v1/base/numbers/#Core.Number">Core.Number</a> cutoff = 1e-3 )</pre>

#### Description

In-place version of the "fracdiff" function.

The source code for this function is in [fracdiff.jl](/src/fracdiff.jl#L16-L18).

#### Arguments

1. <code><a href="https://docs.julialang.org/en/v1/base/arrays/#Core.AbstractArray">Core.AbstractArray</a> data</code> *To be filled out.*
2. <code><a href="https://docs.julialang.org/en/v1/base/numbers/#Core.Number">Core.Number</a> d</code> *To be filled out.*
3. <code><a href="https://docs.julialang.org/en/v1/base/numbers/#Core.Number">Core.Number</a> cutoff</code> *To be filled out.* Defaults to `1e-3`?

#### Returns

This function does not return a value.

#### Example

```julia
julia> fracdiff!()

# This results in...
```

## License

This project is licensed under the [MIT License](https://choosealicense.com/licenses/mit/), see [LICENSE](/LICENSE) for more information.
