return function(n)

    local function computeRow(previous_row)

        local row = { 1 }
        for i = 1, (#previous_row - 1) do
            row[i + 1] = previous_row[i] + previous_row[i + 1]
        end
        table.insert(row, 1)

        return row
    end

    local triangle = {}
    local row = { 1 }
    table.insert(triangle, row)
    for i = 2, n do
        row = computeRow(row)
        table.insert(triangle, row)
    end

    return { rows = triangle, last_row = row }

end
