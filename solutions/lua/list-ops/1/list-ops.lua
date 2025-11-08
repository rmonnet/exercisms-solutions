local function reduce(xs, acc, f)
        
    for _, x in ipairs(xs) do
        acc = f(x, acc)
    end
    return acc
end

local function map(xs, f)

    local ys = {}
    for i, x in ipairs(xs) do
        ys[i] = f(x)
    end
    return ys

end

local function filter(xs, pred)

    local ys = {}
    local i = 1
    for _, x in ipairs(xs) do
        if pred(x) then
            ys[i] = x
            i = i + 1
        end
    end
    return ys
end

return {
  map = map,
  reduce = reduce,
  filter = filter
}
