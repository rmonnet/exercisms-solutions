local Hamming = {}

function Hamming.compute(a,b)

    local n = a:len()
    if n ~= b:len() then
        return -1
    end
    
    local distance = 0
    for i = 1, n do
        if a:byte(i) ~= b:byte(i) then
            distance = distance + 1
        end
    end
    return distance
end

return Hamming
