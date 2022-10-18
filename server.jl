using HTTP, JSON
# using ModelingToolkit, DifferentialEquations
# using Ai4EComponentLib, Ai4EMetaPSE

function job(req::HTTP.Request)
    d = String(req.body)
    # if isa(d, String)
    #     d = JSON.parse(d)
    # end
    error_response = Dict()
    results = Dict()
    try
        results["Your Message"] = d
    catch e
        @error "Something went wrong in the Julia code!" exception = (e, catch_backtrace())
        error_response["error"] = sprint(showerror, e)
    end

    if isempty(error_response)
        return HTTP.Response(200, JSON.json(results))
    else
        @info "An error occured in the Julia code."
        return HTTP.Response(500, JSON.json(error_response))
    end
end

function health(req::HTTP.Request)
    return HTTP.Response(200, JSON.json(Dict("Julia-api" => "healthy!")))
end

# define REST endpoints to dispatch to "service" functions
const ROUTER = HTTP.Router()

HTTP.register!(ROUTER, "POST", "/job", job)
HTTP.register!(ROUTER, "GET", "/health", health)
HTTP.serve(ROUTER, "0.0.0.0", 8081)