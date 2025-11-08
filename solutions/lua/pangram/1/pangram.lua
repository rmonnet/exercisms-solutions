return function(s)

    local s = s:lower()
    for letter in string.gmatch('abcdefghijklmnopqrstuvwxyz', '.') do
        if not s:find(letter) then return false end
    end
    return true

end