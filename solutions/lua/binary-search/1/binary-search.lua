return function(array, target)

    local function binary_search(array, n, target)
        local left = 1
        local right = n
        while left <= right do
            local middle = math.floor((left+right)/2)
            if array[middle] < target then
                left = middle + 1
            elseif array[middle] > target then
                right = middle -1
            else
                return middle
            end
        end
        return -1
    end

    if array == nil then return -1 end
    return binary_search(array, #array, target)
            
end
