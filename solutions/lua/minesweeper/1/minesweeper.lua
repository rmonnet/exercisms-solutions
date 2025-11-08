-- MatrixFromBoard extract a matrix of the cells from the board.
-- This removes cells parts of the frame.
local function matrixFromBoard(board)

  local matrix = {}
  local row_size = string.len(board[1])

  -- account for the frame around the board
  -- recover all non-frame cells into the matrix
  for i = 1, #board - 2 do
    assert(string.len(board[i + 1]) == row_size, 'board must be a rectangle')
    local row = {}
    table.insert(matrix, row)
    local line = board[i + 1]:sub(2, -2)
    for cell in line:gmatch('.') do
      table.insert(row, cell)
    end
  end

  return matrix
end

-- Replace replaces the letter at index in the string and return a new string.
local function replace(s, index, value)

  return s:sub(1, index - 1) .. value .. s:sub(index + 1)
end

-- Transform replace spaces in the board by the number of adjacent mines if any.
local function transform(board)

  local matrix = matrixFromBoard(board)

  for i = 1, #matrix do
    for j = 1, #matrix[1] do
      assert(matrix[i][j]:match('[ *]'), "Board can only contain spaces and asterisks")
      if matrix[i][j] == ' ' then
        local mines = 0

        -- horizontal
        if matrix[i][j - 1] == '*' then mines = mines + 1 end
        if matrix[i][j + 1] == '*' then mines = mines + 1 end
        --vertical
        if matrix[i + 1] and matrix[i + 1][j] == '*' then mines = mines + 1 end
        if matrix[i - 1] and matrix[i - 1][j] == '*' then mines = mines + 1 end
        -- diagonal
        if matrix[i - 1] and matrix[i - 1][j - 1] == '*' then mines = mines + 1 end
        if matrix[i - 1] and matrix[i - 1][j + 1] == '*' then mines = mines + 1 end
        if matrix[i + 1] and matrix[i + 1][j - 1] == '*' then mines = mines + 1 end
        if matrix[i + 1] and matrix[i + 1][j + 1] == '*' then mines = mines + 1 end

        if mines > 0 then
          board[i + 1] = replace(board[i + 1], j + 1, tostring(mines))
        end
      end
    end
  end

  return board
end

return {
  transform = transform
}
