return {
  valid = function(s)

    local s = s:gsub(' ', '')
    if not s:match('^%d%d+$') then return false end

    local digits = {}
    s:gsub('.', function(n) table.insert(digits, tonumber(n)) end)

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
