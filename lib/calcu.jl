using Ai4EMetaPSE

module closureCommonJson
using ModelingToolkit, DifferentialEquations
using Ai4EComponentLib
end
module closureModelJson
using ModelingToolkit, DifferentialEquations
using Ai4EComponentLib
end

function calcu(jsonStrings::String)
    res = closureCommonJson.eval(generatecode(jsonStrings, CommonJson()).script)
    return res
end

function calcu_model(jsonStrings::String)
    res = closureModelJson.eval(generatecode(jsonStrings, ModelJson()).script)
    return res
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
# using Ai4EMetaPSE
# c = generatecode(str, CommonJson()).script

# res = test.eval(c)
# res.retcode
# str = """{
#     "name": "Project Name",
#     "pkgs": [
#         "ModelingToolkit",
#         "DifferentialEquations",
#         "Ai4EComponentLib.IncompressiblePipe"
#     ],
#     "components": [
#         {
#             "name": "Pump",
#             "type": "CentrifugalPump",
#             "args": {
#                 "ω": 5000
#             }
#         },
#         {
#             "name": "A",
#             "type": "Sink_P",
#             "args": {}
#         },
#         {
#             "name": "B",
#             "type": "Sink_P",
#             "args": {}
#         },
#         {
#             "name": "Pipe1",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 2.0
#             }
#         },
#         {
#             "name": "Pipe2",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 7.0
#             }
#         },
#         {
#             "name": "Pipe3",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 7.0
#             }
#         },
#         {
#             "name": "Pipe4",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 9.0
#             }
#         },
#         {
#             "name": "Pipe5",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 5.0
#             }
#         },
#         {
#             "name": "Pipe6",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 4.0
#             }
#         },
#         {
#             "name": "Pipe7",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 5.0
#             }
#         },
#         {
#             "name": "Pipe8",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 1.0
#             }
#         },
#         {
#             "name": "Pipe9",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 10.0
#             }
#         },
#         {
#             "name": "Pipe10",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 2.0
#             }
#         },
#         {
#             "name": "Pipe11",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 2.0
#             }
#         },
#         {
#             "name": "Pipe12",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 3.0
#             }
#         },
#         {
#             "name": "Pipe13",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 2.0
#             }
#         },
#         {
#             "name": "Pipe14",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 1.0
#             }
#         },
#         {
#             "name": "Pipe15",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 2.0
#             }
#         },
#         {
#             "name": "Pipe16",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 3.0
#             }
#         },
#         {
#             "name": "Pipe17",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 6.0
#             }
#         },
#         {
#             "name": "Pipe18",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 6.0
#             }
#         },
#         {
#             "name": "Pipe19",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 6.0
#             }
#         },
#         {
#             "name": "Pipe20",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 1.0
#             }
#         },
#         {
#             "name": "Pipe21",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 1.0
#             }
#         },
#         {
#             "name": "Pipe22",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 7.0
#             }
#         },
#         {
#             "name": "Pipe23",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 3.0
#             }
#         },
#         {
#             "name": "Pipe24",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 3.0
#             }
#         },
#         {
#             "name": "Pipe25",
#             "type": "SimplePipe",
#             "args": {
#                 "L": 2.0
#             }
#         }
#     ],
#     "connections": [
#         [
#             "A.port",
#             "Pump.in"
#         ],
#         [
#             "Pump.out",
#             "Pipe1.in"
#         ],
#         [
#             "Pipe1.out",
#             "Pipe2.in",
#             "Pipe5.in"
#         ],
#         [
#             "Pipe2.out",
#             "Pipe3.in",
#             "Pipe6.in"
#         ],
#         [
#             "Pipe3.out",
#             "Pipe4.in",
#             "Pipe7.in"
#         ],
#         [
#             "Pipe4.out",
#             "Pipe10.out",
#             "Pipe14.in"
#         ],
#         [
#             "Pipe5.out",
#             "Pipe11.in",
#             "Pipe12.in"
#         ],
#         [
#             "Pipe6.out",
#             "Pipe8.in",
#             "Pipe9.in"
#         ],
#         [
#             "Pipe7.out",
#             "Pipe9.out",
#             "Pipe10.in"
#         ],
#         [
#             "Pipe12.out",
#             "Pipe8.out",
#             "Pipe13.in"
#         ],
#         [
#             "Pipe13.out",
#             "Pipe14.out",
#             "Pipe15.in"
#         ],
#         [
#             "Pipe11.out",
#             "Pipe19.in",
#             "Pipe16.in"
#         ],
#         [
#             "Pipe16.out",
#             "Pipe17.in",
#             "Pipe20.in"
#         ],
#         [
#             "Pipe17.out",
#             "Pipe18.in",
#             "Pipe21.in"
#         ],
#         [
#             "Pipe18.out",
#             "Pipe15.out",
#             "Pipe22.in"
#         ],
#         [
#             "Pipe19.out",
#             "Pipe20.out",
#             "Pipe23.in"
#         ],
#         [
#             "Pipe21.out",
#             "Pipe22.out",
#             "Pipe24.in"
#         ],
#         [
#             "Pipe23.out",
#             "Pipe24.out",
#             "Pipe25.in"
#         ],
#         [
#             "B.port",
#             "Pipe25.out"
#         ]
#     ],
#     "u0": [],
#     "timespan": [
#         0,
#         0
#     ],
#     "solver": "Rosenbrock23"
# }"""
# res = calcu_model(str)
