using Ai4EMetaPSE
import Ai4EMetaPSE: getscript

module closureCommonJson
using ModelingToolkit, DifferentialEquations
using Ai4EComponentLib
end
module closureModelJson
using ModelingToolkit, DifferentialEquations
using Ai4EComponentLib
end

function calcu(jsonStrings::String)
    s = getscript(generatecode(jsonStrings, CommonJson()))
    res = closureCommonJson.eval(s)
    return res
end

function calcu_model(jsonStrings::String)
    s = getscript(generatecode(jsonStrings, ModelJson()))
    res = closureModelJson.eval(s)
    return res
end
