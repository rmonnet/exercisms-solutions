return function(numbers)

    local function is_multiple(n)
        for _, number in ipairs(numbers) do
            if n % number == 0 then return true end
        end
        return false
    end

    local res = {}

    res.to = function(max)
        local sum = 0
        for i = 1, max - 1 do
            if is_multiple(i) then
                sum = sum + i
            end
        end
        return sum
    end

    return res

end
