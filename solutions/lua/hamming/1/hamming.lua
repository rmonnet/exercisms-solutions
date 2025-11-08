local Hamming = {}

function Hamming.compute(a,b)

    local n = string.len(a)
    if n ~= string.len(b) then
        return -1
    end
    
    local distance = 0
    for i = 1, n do
        if string.byte(a, i) ~= string.byte(b, i) then
            distance = distance + 1
        end
    end
    return distance
end

return Hamming
