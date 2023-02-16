for sym in [
    :LogLevel, :BelowMinLevel, :AboveMaxLevel,
    :AbstractLogger,
    :NullLogger,
    :handle_message, :shouldlog, :min_enabled_level, :catch_exceptions,
    Symbol("@debug"),
    Symbol("@info"),
    Symbol("@warn"),
    Symbol("@error"),
    Symbol("@logmsg"),
    :with_logger,
    :current_logger,
    :global_logger,
    :disable_logging,
    :SimpleLogger,
    :closed_stream]
    @eval const $sym = Base.CoreLogging.$sym
end

struct Ai4ESimulatorLogger <: AbstractLogger
    stream::IO
    min_level::LogLevel
    message_limits::Dict{Any,Int}
end
function Ai4ESimulatorLogger(stream::IO, min_level=LogLevel(-1))
    Ai4ESimulatorLogger(stream, min_level, Dict{Any,Int}())
end
function Ai4ESimulatorLogger(min_level=LogLevel(-1))
    Ai4ESimulatorLogger(closed_stream, min_level, Dict{Any,Int}())
end
function shouldlog(logger::Ai4ESimulatorLogger, level, _module, group, id)
    get(logger.message_limits, id, 1) > 0
end
min_enabled_level(logger::Ai4ESimulatorLogger) = logger.min_level
global_logger(Ai4ESimulatorLogger())
function handle_message(logger::Ai4ESimulatorLogger, level::LogLevel, message, _module, group, id,
    filepath, line; kwargs...)
    @nospecialize
    if !isempty(kwargs)
        status = get(kwargs, :status, "正在计算!")
        progress = get(kwargs, :progress, "none")
        progress == "done" && status == "正在计算!" ? status = "计算完成！" : nothing
        status_progress = JSON.json(Dict("status" => status, "progress" => progress))
        try
            send(client, status_progress)
            println(status_progress)
        catch
            nothing
        end
    end
    nothing
end