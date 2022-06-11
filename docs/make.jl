# Inside make.jl
using Documenter, FinanceTools

makedocs(
    modules = [FinanceTools],
    doctest = true,
    sitename = "FinanceTools.jl",
    )
