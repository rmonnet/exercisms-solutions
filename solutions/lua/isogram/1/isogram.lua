return function(s)

    -- remove spaces and hyphens
    s = s:gsub('[ -]', '')
    -- make case insensitive
    s = s:lower()
    
    local letters = {}
    for i = 1, s:len() do
        c = s:sub(i, i)
        if letters[c] then
            return false
        end
        letters[c] = true
    end
    return true
end
