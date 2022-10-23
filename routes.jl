using Genie.Router, Genie.Requests
using JSON

route("/") do
  serve_static_file("index.html")
end

route("/health", method=GET) do
  JSON.json(Dict("Julia-API" => "healthy!"))
end

route("/job", method=POST) do
  JSON.json(Dict("Your Message" => rawpayload()))
end

route("/api/commonjson", method=POST) do
  error_response = Dict()
  results = Dict()
  try
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

route("/api/modeljson", method=POST) do
  error_response = Dict()
  results = Dict()
  try
    jsonString = rawpayload()
    res = calcu_model(jsonString)
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
