begin

    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:71 =#
    using Pkg
    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:72 =#
    pkgNeeds = ["ModelingToolkit", "DifferentialEquations", "Ai4EComponentLib"]
    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:73 =#
    alreadyGet = keys((Pkg.project()).dependencies)
    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:74 =#
    toAdd = [package for package = pkgNeeds if package ∉ alreadyGet]
    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:75 =#
    if isempty(toAdd)
        nothing
    else
        Pkg.add(toAdd)
    end
    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:76 =#
    using ModelingToolkit, DifferentialEquations, Ai4EComponentLib.IncompressiblePipe, Ai4EComponentLib
    @named Pump = CentrifugalPump(ω=5000)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named A = Sink_P()    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named B = Sink_P()    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe1 = SimplePipe(L=2)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe2 = SimplePipe(L=7)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe3 = SimplePipe(L=7)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe4 = SimplePipe(L=9)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe5 = SimplePipe(L=5)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe6 = SimplePipe(L=4)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe7 = SimplePipe(L=5)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe8 = SimplePipe(L=1)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe9 = SimplePipe(L=10)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe10 = SimplePipe(L=2)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe11 = SimplePipe(L=2)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe12 = SimplePipe(L=3)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe13 = SimplePipe(L=2)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe14 = SimplePipe(L=1)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe15 = SimplePipe(L=2)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe16 = SimplePipe(L=3)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe17 = SimplePipe(L=6)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe18 = SimplePipe(L=6)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe19 = SimplePipe(L=6)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe20 = SimplePipe(L=1)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe21 = SimplePipe(L=1)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe22 = SimplePipe(L=7)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe23 = SimplePipe(L=3)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe24 = SimplePipe(L=3)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    @named Pipe25 = SimplePipe(L=2)    #= e:\develop\Ai4EMetaPSE.jl\src\solution.jl:128 =#
    components = [Pump, A, B, Pipe1, Pipe2, Pipe3, Pipe4, Pipe5, Pipe6, Pipe7, Pipe8, Pipe9, Pipe10, Pipe11, Pipe12, Pipe13, Pipe14, Pipe15, Pipe16, Pipe17, Pipe18, Pipe19, Pipe20, Pipe21, Pipe22, Pipe23, Pipe24, Pipe25]
    eqs = [connect(A.port, Pump.in), connect(Pump.out, Pipe1.in), connect(Pipe1.out, Pipe2.in, Pipe5.in), connect(Pipe2.out, Pipe3.in, Pipe6.in), connect(Pipe3.out, Pipe4.in, Pipe7.in), connect(Pipe4.out, Pipe10.out, Pipe14.in), connect(Pipe5.out, Pipe11.in, Pipe12.in), connect(Pipe6.out, Pipe8.in, Pipe9.in), connect(Pipe7.out, Pipe9.out, Pipe10.in), connect(Pipe12.out, Pipe8.out, Pipe13.in), connect(Pipe13.out, Pipe14.out, Pipe15.in), connect(Pipe11.out, Pipe19.in, Pipe16.in), connect(Pipe16.out, Pipe17.in, Pipe20.in), connect(Pipe17.out, Pipe18.in, Pipe21.in), connect(Pipe18.out, Pipe15.out, Pipe22.in), connect(Pipe19.out, Pipe20.out, Pipe23.in), connect(Pipe21.out, Pipe22.out, Pipe24.in), connect(Pipe23.out, Pipe24.out, Pipe25.in), connect(B.port, Pipe25.out)]
    init = Dict()
    timespan = (0.0, 1.0)
    Model = compose(ODESystem(eqs, t; name=:Model), components; name=:system)
    Project_Name = solve(ODEProblem(structural_simplify(Model), init, timespan, saveat=abs(timespan[2] - timespan[1]) / 100), Rosenbrock23())

end