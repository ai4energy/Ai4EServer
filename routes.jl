using Genie.Router, Genie.Requests
using JSON, Dates
using HTTP, HTTP.WebSockets
using Genie.Configuration
include("./lib/Ai4ESimulatorLogger.jl")

const CORS_RES_HEADERS = [
  "Access-Control-Allow-Origin" => "*",
  "Access-Control-Allow-Headers" => "*",
  "Access-Control-Allow-Methods" => "POST, GET, OPTIONS"
]

Genie.config.cors_allowed_origins = ["*"]
Genie.config.cors_headers = Dict(CORS_RES_HEADERS)

route("/") do
  serve_static_file("index.html")
end

route("/health", method=GET) do
  JSON.json(Dict("Julia-API" => "healthy!"))
end

route("/job", method=POST) do
  @show string(now()) * "  /job to handle"
  rawpayload()
end

route("/api/commonjson", method=POST) do
  error_response = Dict()
  results = Dict()
  try
    @info string(now()) * "  /api/commonjson to handle" rawpayload()
    jsonString = rawpayload()
    res = calcu(jsonString)
    results["State"] = string(res.retcode)
  catch e
    @error "Something went wrong in the Julia code!" exception = (e, catch_backtrace())
    error_response["error"] = sprint(showerror, e)
  end

  if isempty(error_response)
    return JSON.json(results)
  else
    @info "An error occured in the Julia code."
    return JSON.json(error_response)
  end
end

route("/api/getResult", method=GET) do
  error_response = Dict()
  results = Dict()
  try
    @info string(now()) * "  /api/getResult"
    res = getLatestReslut()
    results["status"] = "Success"
    results["code"] = 200
    results["data"] = res
  catch e
    @error "Something went wrong in the Julia code!" exception = (e, catch_backtrace())
    error_response["error"] = sprint(showerror, e)
  end

  if isempty(error_response)
    return JSON.json(results)
  else
    @info "An error occured in the Julia code."
    return JSON.json(error_response)
  end
  JSON.json(Dict("Julia-API" => "healthy!"))
end

route("/api/modeljson", method=POST) do
  @logmsg LogLevel(-1) "ODESystem" _id = :OrdinaryDiffEq status = "准备计算！" progress = "none" 
  error_response = Dict()
  results = Dict()
  try
    @show string(now()) * "  /api/modeljson to handle" rawpayload()
    jsonString = rawpayload()
    name = replace(JSON.parse(jsonString)["name"], " " => "_")
    (res, sol) = calcu_model(jsonString, name)
    results["status"] = string(sol.retcode)
    results["code"] = 200
    @show "Success!"
  catch e
    # @show "Something went wrong in the Julia code!" exception = (e, catch_backtrace())
    @logmsg LogLevel(-1) "ODESystem" _id = :OrdinaryDiffEq status = "计算出错！" progress = "none" 
    @show "Something went wrong in the Julia code! " * sprint(showerror, e)
    error_response["error"] = sprint(showerror, e)
    results["code"] = 404
  end

  if isempty(error_response)
    return JSON.json(results)
  else
    @info "An error occured in the Julia code."
    return JSON.json(error_response)
  end
end

task = @async WebSockets.listen("0.0.0.0", 8082) do ws
  global client = ws
  for msg in ws
    !isempty(msg) ? send(ws, "Hello, you said: $msg") : nothing
  end
end

route("/foo/bar") do
  results = Dict()
  jsonString = """{
    "name": "Lithium battery",
    "pkgs": [
        "ModelingToolkit",
        "DifferentialEquations",
        "Ai4EComponentLib.Electrochemistry"
    ],
    "components": [
        {
            "name": "batter",
            "type": "Lithium_ion_batteries",
            "args": {}
        },
        {
            "name": "Pv",
            "type": "PhotovoltaicCell",
            "args": {}
        },
        {
            "name": "ground",
            "type": "Ground",
            "args": {}
        }
    ],
    "connections": [
        [
            "batter.p",
            "Pv.p"
        ],
        [
            "batter.n",
            "Pv.n",
            "ground.g"
        ]
    ],
    "u0": [
        "batter.v_f => 0.5",
        "batter.v_s => 0.5",
        "batter.v_soc => 0.5"
    ],
    "timespan": [
        0.0,
        36000.0,
        1.0
    ],
    "solver": "Rosenbrock23"
    }"""
  name = replace(JSON.parse(jsonString)["name"], " " => "_")
  (res, sol) = calcu_model(jsonString, name)
  results["status"] = string(sol.retcode)
  results["code"] = 200
end

route("/foo/car") do
  s = quote
    @logmsg LogLevel(-1) "ODESystem" _id = :OrdinaryDiffEq status = "准备计算！" progress = "none" 
    sleep(1)
    @logmsg LogLevel(-1) "ODESystem" _id = :OrdinaryDiffEq status = "正在加载科学计算库！" progress = "none"    #= none:1 =#
    sleep(1)
    using JSON
    using DifferentialEquations
    @logmsg LogLevel(-1) "ODESystem" _id = :OrdinaryDiffEq status = "正在构建数学模型！" progress = "none"    #= none:1 =#
    sleep(2)
    @logmsg LogLevel(-1) "ODESystem" _id = :OrdinaryDiffEq status = "正在简化模型！" progress = "none"    #= none:1 =#
    sleep(2)
    solve(
      ODEProblem((u, p, t) -> (sleep(0.01); -u), 1.0, nothing),
      Euler();
      dt=0.5,
      tspan=(0.0, 180.0),
      progress=true,
      progress_steps=5
    )
  end
  sol = eval(s)
  return "Hello from Julia by axios!"
end