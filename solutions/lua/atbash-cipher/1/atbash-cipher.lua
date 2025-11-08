function encodeLetter(letter)

  -- don't encode numbers
  if '0' <= letter and letter <= '9' then return letter end

  local index = string.byte(letter) - string.byte('a')
  -- only encode letters ('a' to 'z')
  if index < 0 or index > 25 then return nil end

  return string.char(string.byte('a') + (25 - index))
end

return {
  encode = function(plaintext)

    local res = {}
    local index = 0

    for letter in plaintext:lower():gmatch('.') do

      local code = encodeLetter(letter)
      if code then

        -- add spacing every 5 encoded characters
        if index == 5 then
          table.insert(res, ' ')
          index = 0
        end

        table.insert(res, code)
        index = index + 1
      end
    end

    return table.concat(res)

  end
}
