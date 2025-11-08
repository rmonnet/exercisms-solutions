local NUMBERS = {
  [' _ | ||_|   '] = '0',
  ['     |  |   '] = '1',
  [' _  _||_    '] = '2',
  [' _  _| _|   '] = '3',
  ['   |_|  |   '] = '4',
  [' _ |_  _|   '] = '5',
  [' _ |_ |_|   '] = '6',
  [' _   |  |   '] = '7',
  [' _ |_||_|   '] = '8',
  [' _ |_| _|   '] = '9'
}

-- Flatten takes the input string and breaks it in group of characters.
-- Since each letter is on a 4x3 grid, 4 lines (newlines separated strings) form a group
-- of letters. If there are more than four lines, then the function will return more groups.
-- Each letter is represented as its four lines concatenated into a string (without newlines).
-- The Result looks like { {string_for_letter_1_group_1, string_for_letter_2_group_1, ...}, {group_2}, ...}.
local function flatten(grid)

  local res = {}
  local nlines = 1
  local group = {}
  table.insert(res, group)
  local nletters_in_group

  for line in grid:gmatch('[^\n]+') do

    -- start a new group after 4 lines
    if nlines == 5 then
      group = {}
      table.insert(res, group)
      nlines = 1
    end

    -- check the input consists of group of lines of the same size (and consistent with of the 3x4 grid)
    if nlines == 1 then
      assert(string.len(line) % 3 == 0, 'input is incorrectly sized')
      nletters_in_group = string.len(line) // 3
    else
      assert(string.len(line) // 3 == nletters_in_group, 'input is incorrectly sized')
    end

    for i = 1, string.len(line), 3 do
      local index = 1 + i // 3
      group[index] = (group[index] or '') .. line:sub(i, i + 2)
    end

    nlines = nlines + 1
  end

  return res
end

return {
  convert = function(s)

    local res = {}

    for i, group in ipairs(flatten(s)) do
      if i > 1 then
        table.insert(res, ',')
      end
      for _, letter in ipairs(group) do
        table.insert(res, NUMBERS[letter] or '?')
      end
    end

    return table.concat(res)
  end
}
