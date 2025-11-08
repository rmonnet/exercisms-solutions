return function(n)

    local function primes()

        if n < 2 then coroutine.yield(nil) end

        -- initialize the prime array to true (for all odd n greater than 2)
        local primes = { false, true }
        for i = 3, n do
            primes[i] = (i % 2 ~= 0)
        end

        for i = 3, math.sqrt(n), 2 do
            if primes[i] then
                for j = i * i, n, i do
                    primes[j] = false
                end
            end
        end

        for i, p in ipairs(primes) do
            if p then
                coroutine.yield(i)
            end
        end
        coroutine.yield(nil)
    end

    return coroutine.create(primes)

end
