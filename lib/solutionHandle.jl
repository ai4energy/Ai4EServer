solutionHandle() = Symbol("resDict")

function solutionHandle(name::String)
    return quote
        varNames = map(ModelingToolkit.getmetadata.(states(Model), ModelingToolkit.VariableSource)) do x
            replace(string(getindex(x, 2)), "₊" => ".")
        end
        
        NameVec = map(varNames) do names
            names = string.(split(names, "."))
            for i in length(names):-1:1
                names[i] = join(names[1:i], ".")
            end
            return names
        end

        function addToDict!(dicts::Vector, names::Vector{String}, index::Int=1)
            if index == lastindex(names)
                return push!(dicts, names[index])
            end
            for d in dicts
                if d isa Dict && haskey(d, names[index])
                    return addToDict!(d[names[index]], names, index + 1)
                end
            end
            return push!(dicts, Dict(names[index] => addToDict!([], names, index + 1)))
        end

        varinfo = Dict[]
        map(x -> addToDict!(varinfo, x), NameVec)

        varRes = Dict(map(varNames) do var
            var => $(Symbol(name))[eval(Meta.parse(var))]
        end)

        resDict = Dict(
            "t" => $(Symbol(name)).t,
            "sol" => varRes,
            "varinfo" => varinfo
        )
    end
end