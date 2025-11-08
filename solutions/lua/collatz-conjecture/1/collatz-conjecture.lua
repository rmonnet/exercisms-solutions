return function(n)

    local steps = 0

    while true do
        assert(n > 0 and n == math.floor(n), 'Only positive numbers are allowed')
        if n == 1 then return steps end
        steps = steps + 1
        n = (n % 2 == 0) and (n / 2) or (3 * n + 1)
    end
end
