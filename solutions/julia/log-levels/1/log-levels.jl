function message(msg)
    rg = findfirst(": ", msg)
    return strip(msg[last(rg)+1:end])
end

function log_level(msg)
    rg = findfirst("]: ", msg)
    return lowercase(msg[2:first(rg)-1])
end

function reformat(msg)
    msg_only = message(msg)
    level_only = log_level(msg)
    return "$msg_only ($level_only)"
end
