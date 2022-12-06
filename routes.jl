using Genie.Router, Genie.Requests
using JSON, Dates
using HTTP

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
  error_response = Dict()
  results = Dict()
  try
    @info string(now()) * "  /api/modeljson to handle" rawpayload()
    jsonString = rawpayload()
    name = replace(JSON.parse(jsonString)["name"], " " => "_")
    (res, sol) = calcu_model(jsonString, name)
    results["status"] = string(sol.retcode)
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
end
