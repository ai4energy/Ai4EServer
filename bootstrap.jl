(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir
using ModelingToolkit, DifferentialEquations
using Ai4EComponentLib, Ai4EMetaPSE
using Ai4EServer
include("./lib/calcu.jl")
const UserApp = Ai4EServer
Ai4EServer.main()
