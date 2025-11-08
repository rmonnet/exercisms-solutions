local function flatten(input)

    local res = {}
    for _, v in ipairs(input) do
        if type(v) ~= 'table' then
            if v then
                table.insert(res, v)
            end
        else
            for _, v1 in ipairs(flatten(v)) do
                table.insert(res, v1)
            end
        end
    end

    return res
end

return flatten
