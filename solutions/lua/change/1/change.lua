local function sortedCopy(array)

    local res = {}
    for i, v in ipairs(array) do
        res[i] = v
    end

    table.sort(res, function(a, b) return b < a end)

    return res
end

return function(amount, values)

    -- make sure the values are decreasing
    local sortedValues = sortedCopy(values)
    local change = {}

    for _, value in ipairs(sortedValues) do
        change[value] = 0
        while amount - value >= 0 do
            change[value] = change[value] + 1
            amount = amount - value
        end
    end

    if amount > 0 then return nil end

    local res = {}
    for _, value in ipairs(values) do
        table.insert(res, change[value])
    end

    return res
end
