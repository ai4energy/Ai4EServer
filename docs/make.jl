using Documenter
DocMeta.setdocmeta!(Ai4EComponentLib, :DocTestSetup, :(using Ai4EServer); recursive=true)
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
