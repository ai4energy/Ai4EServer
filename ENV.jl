ENV["JULIA_PKG_SERVER"] = "https://mirrors.tuna.tsinghua.edu.cn/julia/";
using Pkg;
Pkg.activate(".");
Pkg.instantiate();
Pkg.precompile()

# begin
#     pkgNeeds = [
#         "HTTP",
#         "ModelingToolkit",
#         "DifferentialEquations",
#         "Ai4EComponentLib",
#         "Ai4EMetaPSE"
#     ]
#     alreadyGet = keys(Pkg.project().dependencies)
#     toAdd = [package for package in pkgNeeds if package ∉ alreadyGet]
#     isempty(toAdd) ? nothing : Pkg.add(toAdd)
# end