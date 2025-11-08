--isInteger Checks if the number is an integer.
local function isInteger(n)
    return n == math.floor(n)
end

-- key returns a key for a triplet
local function key(triplet)
    return table.concat(triplet, ":")
end

-- build a triplet of sorted values
local function triplet(a, b, c)
    local res = { math.floor(a), math.floor(b), math.floor(c) }
    table.sort(res)
    return res
end

-- Computes all the Pythagorean Triplets for which the sum of factors equals sum
return function(sum)


    -- This algorithm may finds duplicate solutions (for different values of k).
    -- Use a set so we can easily check for existing solutions.
    local solutions = {}


    -- Check all k values until the sumOverK is reduces to 12 (smallest known triplet).
    for k = 1, sum / 12 do

        local sumOverK = sum / k

        if isInteger(sumOverK) then
            local m0 = math.ceil(math.sqrt(sumOverK) / 2)
            local m1 = math.sqrt(sumOverK / 2)

            -- Checks the m between sqrt(sum/k)/2 and sqrt (sum/k/2)
            -- for values of n that are integers smaller than m.
            -- use a while loop because the lua for loop only provides '<=' condition, in this case we need a strict '<'
            local m = m0
            while m < m1 do
                local n = sumOverK / (2 * m) - m
                if isInteger(n) and n < m then
                    local a = k * (m * m - n * n)
                    local b = k * (2 * m * n)
                    local c = k * (m * m + n * n)
                    local solution = triplet(a, b, c)
                    solutions[key(solution)] = solution
                end
                m = m + 1
            end
        end
    end

    -- convert the set to an array
    -- no need to sort the triplet as the test does it
    local res = {}
    for _, solution in pairs(solutions) do
        table.insert(res, solution)
    end
    return res
end
