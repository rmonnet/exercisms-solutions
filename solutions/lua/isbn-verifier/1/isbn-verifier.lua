local function isbnToDigits(isbn)

  local res = {}
  for char in isbn:gmatch('.') do
    local digit = (char == 'X') and 10 or tonumber(char)
    table.insert(res, digit)
  end

  if #res == 9 then
    table.insert(res, 0)
  end

  return res
end

local function validate(x)

  local formula = x[1] * 10 + x[2] * 9 + x[3] * 8 + x[4] * 7 + x[5] * 6 + x[6] * 5
      + x[7] * 4 + x[8] * 3 + x[9] * 2 + x[10] * 1
  return formula % 11 == 0

end

return {
  valid = function(isbn)

    -- remove hyphens
    local cleaned_up_isbn = isbn:gsub('-', '')

    -- check the isbn is valid
    if not cleaned_up_isbn:match('^%d%d%d%d%d%d%d%d%d[0-9X]?$') then return false end

    return validate(isbnToDigits(cleaned_up_isbn))

  end
}
