include("solutionHandle.jl")

using Ai4EMetaPSE
import Ai4EMetaPSE: getscript

module closureCommonJson
using ModelingToolkit, DifferentialEquations
using Ai4EComponentLib
include("Ai4ESimulatorLogger.jl")
end
module closureModelJson
using ModelingToolkit, DifferentialEquations
using JSON
using Ai4EComponentLib
using Ai4EComponentLib.Electrochemistry
using Ai4EComponentLib.ThermodynamicCycle
using Ai4EComponentLib.AirPipeSim
using Ai4EComponentLib.IncompressiblePipe
include("Ai4ESimulatorLogger.jl")
end

function calcu(jsonStrings::String)
    s = getscript(generatecode(jsonStrings, CommonJson()))
    res = closureCommonJson.eval(s)
    return res
end

function calcu_model(jsonStrings::String, name::String="Project_Name")
    s = getscript(generatecode(jsonStrings, ModelJson()))
    @show s
    sol = closureModelJson.eval(s)
    res = closureModelJson.eval(solutionHandle(name))
    return (res, sol)
end

function getLatestReslut()
    return closureModelJson.eval(solutionHandle())
end

# s = read("test/testCode.jl", String)
# ex = Meta.parse(s)
# sol = closureModelJson.eval(ex)
# res = closureModelJson.eval(solutionHandle("Project_Name"))
