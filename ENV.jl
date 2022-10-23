ENV["JULIA_PKG_SERVER"] = "https://mirrors.tuna.tsinghua.edu.cn/julia/";
using Pkg
Pkg.activate(".")
Pkg.instantiate()
Pkg.precompile(); 