local function stringToDigits(s)

  local digits = {}
  for letter in s:gmatch('.') do
    table.insert(digits, tonumber(letter))
  end

  return digits
end

return {
  valid = function(s)

    local s = s:gsub(' ', '')
    if not s:match('^%d%d+$') then return false end

    local digits = stringToDigits(s)

    -- step 1, double every second digit from the right and modulo 9
    for i = #digits - 1, 1, -2 do
      digits[i] = (2 * digits[i]) % 9
    end

    -- step 2, sum all the digits
    local sum = 0
    for _, digit in ipairs(digits) do
      sum = sum + digit
    end

    -- the sum must be divisible by 10 to be valid
    return (sum % 10 == 0)

  end
}
