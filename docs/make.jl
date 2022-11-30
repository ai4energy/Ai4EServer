using Documenter
using Ai4EServer

DocMeta.setdocmeta!(Ai4EServer, :DocTestSetup, :(using Ai4EServer); recursive=true)
makedocs(;
    sitename="Ai4EServer",
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/ai4energy/Ai4EServer.git",
    devbranch="main",
)
