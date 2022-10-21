function job(req::HTTP.Request)
    error_response = Dict()
    results = Dict()
    try
        results["Your Message"] = String(req.body)
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

function cal_commonJson(req::HTTP.Request)
    error_response = Dict()
    results = Dict()
    try
        d = String(req.body)
        res = calcu(d)
        results["State"] = string(res.retcode)
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

function info(req::HTTP.Request)
    str::String = """
    Meathod * API                   : Information                 
    GET     * /                     : See API list
    GET     * /health               : Test if serve works well
    POST    * /job                  : Return string post
    POST    * /api/commonjson       : To calculate CommonJson type
    """
    return HTTP.Response(200, str)
end
