using HTTP, JSON
using ModelingToolkit, DifferentialEquations
using Ai4EComponentLib, Ai4EMetaPSE

include("libs/calcu.jl")
include("libs/rounters.jl")

# define REST endpoints to dispatch to "service" functions
const ROUTER = HTTP.Router()

HTTP.register!(ROUTER, "POST", "/job", job)
HTTP.register!(ROUTER, "POST", "/api/commonjson", cal_commonJson)
HTTP.register!(ROUTER, "GET", "/health", health)
HTTP.register!(ROUTER, "GET", "/", info)

@info "Start the Server!"

HTTP.serve(ROUTER, "0.0.0.0", 8081)