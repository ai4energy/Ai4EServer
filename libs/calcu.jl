function calcu(jsonStrings::String)
    return eval(generatecode(jsonStrings, CommonJson()).script)
end

# str::String = """{
#     "name": "Name",
#     "pkgs": [
#         "ModelingToolkit",
#         "DifferentialEquations"
#     ],
#     "variables": [
#         "x(t) = 1.0",
#         "y(t) = 1.0",
#         "z(t) = 2.0"
#     ],
#     "parameters": [
#         "σ = 1.0",
#         "ρ = 3.0",
#         "β = 5.0" 
#     ],
#     "equations": [
#         "der(x) = σ*(y - x)",
#         "der(y) = x*(ρ - z) - y",
#         "der(z) = x*y - β*z"
#     ],
#     "u0": [
#         "x => 1.0",
#         "y => 2.0",
#         "z => 3.0"
#     ],
#     "timespan": [0,1],
#     "solver": "Rosenbrock23"
# }"""
# res = calcu(str)
# res.retcode