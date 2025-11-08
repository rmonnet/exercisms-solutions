-- StringToMatrix converts the input string to a matrix (each row in the matrix is delimited
--  by a newline in the input).
local function stringToMatrix(s)

    local matrix = {}

    for line in s:gmatch('[^\n]*') do
        local row = {}
        table.insert(matrix, row)
        for cell in line:gmatch('.') do
            table.insert(row, cell)
        end
    end

    return matrix
end

-- MaxRowSize returns the size of the longuest row in the matrix.
local function maxRowSize(matrix)

    local max = 0
    for _, row in ipairs(matrix) do
        if #row > max then
            max = #row
        end
    end

    return max
end

-- Transpose transposes the matrix and pad to the left but not to the right.
local function transpose(matrix)

    local transposed = {}
    local ncols = maxRowSize(matrix)

    -- initialize the transposed matrix
    for r = 1, ncols do
        transposed[r] = {}
    end

    -- to pad to the left, one needs to start filling the transpose matrix column first
    -- and start with the right-most column.
    -- Once a column has been filled with N elements, all left columns must contain at least N
    -- elements (left padding)/
    max = 0
    for c = #matrix, 1, -1 do
        max = math.max(max, #matrix[c])
        for r = 1, max do
            transposed[r][c] = matrix[c][r] or ' '
        end
    end

    return transposed
end

-- MatrixToString converts a matrix back to a string with each row being separated with
-- a newline.
local function matrixToString(matrix)

    local s = {}

    for _, row in ipairs(matrix) do
        --local line = table.concat(row)
        --line = trimRight(line)
        table.insert(s, table.concat(row))
    end

    return table.concat(s, '\n')
end

return function(s)

    return matrixToString(transpose(stringToMatrix(s)))

end
