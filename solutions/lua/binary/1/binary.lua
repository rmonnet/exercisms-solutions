local function to_decimal(input)

    if not string.match(input, '^[01]*$') then return 0 end

    local res = 0
    local factor = 1
    for _, d in ipairs{string.byte(string.reverse(input), 1, -1)} do
        res = res + (d - string.byte('0')) * factor
        factor = factor * 2
    end
    return res
end

return {
  to_decimal = to_decimal
}
