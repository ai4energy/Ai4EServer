using Pkg

Pkg.activate(".")
Pkg.status()
begin
    pkgNeeds = [
        "HTTP",
        "ModelingToolkit",
        "DifferentialEquations",
        "Ai4EComponentLib",
        "Ai4EMetaPSE"
    ]
    alreadyGet = keys(Pkg.project().dependencies)
    toAdd = [package for package in pkgNeeds if package ∉ alreadyGet]
    isempty(toAdd) ? nothing : Pkg.add(toAdd)
end