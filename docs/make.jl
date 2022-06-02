# Inside make.jl
push!(LOAD_PATH,"../src/")
using FinanceTools

using Documentermakedocs(
         sitename = "FinanceTools.jl",
         modules  = [FinanceTools],
         pages=[
                "Home" => "index.md"
               ])deploydocs(;
    repo="github.com/joshniemela/FinanceTools.jl",
)