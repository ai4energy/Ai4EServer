using Documenter

makedocs(;
    sitename="Ai4EServer",
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/ai4energy/Ai4EServer.git",
    devbranch="main",
    versions = nothing
)
