-- Vertical transposes the puzzle to a vertical (top to bottom) puzzle.
local function vertical(puzzle)

    local nrows = #puzzle
    local ncols = #puzzle[1]
    local transpose = {}

    for c = 1, ncols do
        transpose[c] = {}
        for r = 1, nrows do
            transpose[c][r] = puzzle[r]:sub(c, c)
        end
        transpose[c] = table.concat(transpose[c])
    end

    return transpose
end

-- Diagonal transforms the puzzle into a diagonal puzzle.
-- The variable 'dir' indicates if the diagonal is right leaning
-- (dir==1) or left leaning (dir==-1).
local function diagonal(puzzle, dir)

    local nrows = #puzzle
    local ncols = #puzzle[1]
    local min_c = (dir == 1) and 1 or ncols
    local max_c = (dir == 1) and ncols or 1
    local diagonal = {}

    -- build all diagonals starting on the first row
    for c = min_c, max_c, dir do
        local row = {}
        local r0, c0 = 1, c
        while r0 <= nrows and c0 >= 1 and c0 <= ncols do
            table.insert(row, puzzle[r0]:sub(c0, c0))
            r0, c0 = r0 + 1, c0 + dir
        end
        table.insert(diagonal, table.concat(row))
    end

    -- build all diagonals starting on the other rows (only the 1st/last column diagonal is needed)
    for r = 2, nrows do
        local row = {}
        local r0, c0 = r, min_c
        while r0 <= nrows and c0 >= 1 and c0 <= ncols do
            table.insert(row, puzzle[r0]:sub(c0, c0))
            r0, c0 = r0 + 1, c0 + dir
        end
        table.insert(diagonal, table.concat(row))
    end

    return diagonal
end

-- FindHorizontal finds a word into an horizontal puzzle.
-- It returns the row the word was found on and the first/last columns.
local function findHorizontal(puzzle, word)

    for i = 1, #puzzle do
        local first, last = puzzle[i]:find(word)
        if first then return first, last, i
        end

    end
end

-- FindDiagonal finds a word into a diagonal puzzle.
-- It returns the first/last row/column where the word was found.
-- The variable 'dir' indicates if the diagonal is right leaning
-- (dir==1) or left leaning (dir==-1).
local function findDiagonal(puzzle, word, nrows, ncols, dir)

    local first, last, row = findHorizontal(puzzle, word)
    if first then
        -- the 1st nrows rows come from the diagonals built with the puzzle first row
        -- the others come from each of the following rows respectively
        local first_row = (row <= nrows) and 1 or (row - nrows + 1)
        -- we then have to adjust for the position of the element in the diagonal
        first_row = first_row + first - 1
        -- we have to shift the column only for the first nrows rows
        local first_col = (row <= nrows) and row or 1
        -- for a left diagonal, we need to count columns from the left
        if dir == -1 then first_col = ncols - first_col + 1 end
        -- we then have to adjust for the position of the element in the diagonal
        first_col = first_col + dir * (first - 1)
        -- shift down row and column for the position of the last element
        local last_row = first_row + last - first
        local last_col = first_col + dir * (last - first)

        return first_col, first_row, last_col, last_row
    end
end

return function(puzzle)

    local res = {}

    local nrows = #puzzle
    local ncols = #puzzle[1]
    local top_bottom_puzzle = vertical(puzzle)
    local right_diagonal_puzzle = diagonal(puzzle, 1)
    local left_diagonal_puzzle = diagonal(puzzle, -1)

    function res.find(word)

        local first_col, first_row, last_col, last_row, row

        -- look left to right
        first_col, last_col, row = findHorizontal(puzzle, word)
        if first_col then return { first_col, row }, { last_col, row } end

        -- look right to left
        first_col, last_col, row = findHorizontal(puzzle, word:reverse())
        if first_col then return { last_col, row }, { first_col, row } end

        -- look top to bottom
        first_col, last_col, row = findHorizontal(top_bottom_puzzle, word)
        if first_col then return { row, first_col }, { row, last_col } end

        -- look bottom to top
        first_col, last_col, row = findHorizontal(top_bottom_puzzle, word:reverse())
        if first_col then return { row, last_col }, { row, first_col } end

        -- look top-left to bottom-right
        first_col, first_row, last_col, last_row = findDiagonal(right_diagonal_puzzle, word, nrows, ncols, 1)
        if first_col then return { first_col, first_row }, { last_col, last_row } end

        -- look bottom-right to top-left
        first_col, first_row, last_col, last_row = findDiagonal(right_diagonal_puzzle, word:reverse(), nrows, ncols, 1)
        if first_col then return { last_col, last_row }, { first_col, first_row } end

        -- look top-right to bottom-left
        first_col, first_row, last_col, last_row = findDiagonal(left_diagonal_puzzle, word, nrows, ncols, -1)
        if first_col then return { first_col, first_row }, { last_col, last_row } end

        -- look bottom-left to top-right
        first_col, first_row, last_col, last_row = findDiagonal(left_diagonal_puzzle, word:reverse(), nrows, ncols, -1)
        if first_col then return { last_col, last_row }, { first_col, first_row } end

    end

    return res

end
