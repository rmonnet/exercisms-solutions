local function stringToDigits(stringOfDigits)

    local digits = {}
    for i, d in ipairs { stringOfDigits:byte(1, -1) } do
        digits[i] = d - string.byte('0')
    end

    return digits
end

local function product(...)

    local res = 1
    for _, v in ipairs { ... } do
        res = res * v
    end

    return res
end

return function(config)

    local stringOfDigits = config.digits
    local span = config.span

    if span == 0 then return 1 end

    assert(span > 0, 'Span must be greater than zero')
    assert(span <= stringOfDigits:len(), 'Span must be smaller than string length')
    assert(string.match(stringOfDigits, '^[0-9]*$'), 'Digits input must only contain digits')

    local digits = stringToDigits(stringOfDigits)
    local max = -math.huge
    for i = 1, #digits - span + 1 do
        local p = product(table.unpack(digits, i, i + span - 1))
        if p > max then
            max = p
        end
    end
    return max
end
