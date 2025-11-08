return function (s)
        
    local matrix = {}
    matrix._rows = {}

    for w in s:gmatch("[^\n]+") do
        local row = {}
        for n in w:gmatch("[^ ]+") do
            table.insert(row, tonumber(n))
        end
        table.insert(matrix._rows, row)
    end
    
    matrix.row = function(r)
        return matrix._rows[r]
    end

    matrix.column = function(c)
        local res = {}
        for r = 1, #matrix._rows do
            table.insert(res, matrix._rows[r][c])
        end
        return res
    end

    return matrix
end