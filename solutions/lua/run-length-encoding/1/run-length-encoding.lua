return {
        
  encode = function(s)

    if string.len(s) == 0 then return "" end

    local res = {}
    local previousLetter = string.byte(s, 1)
    local count = 1
            
    for i = 2, string.len(s) do
        local currentLetter = string.byte(s, i)
        if currentLetter ~= previousLetter then
            if count > 1 then
                table.insert(res, tostring(count))
            end
            table.insert(res, string.char(previousLetter))
            previousLetter = currentLetter
            count = 1
        else
            count = count + 1        
        end
    end
        
    if count > 1 then
        table.insert(res, tostring(count))
    end
    table.insert(res, string.char(previousLetter))

    return table.concat(res)
  end,

  decode = function(s)
            
    local res = {}
            
    for count, letter in string.gmatch(s, "(%d*)([%l%u ])") do
        if string.len(count) == 0 then
            table.insert(res, letter)
        else
            table.insert(res, string.rep(letter, tonumber(count)))
        end
    end
        
    return table.concat(res)
  end
}
