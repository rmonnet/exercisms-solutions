return function(array, target)

    if array == nil then return -1 end
        
    local left = 1
    local right = #array
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
