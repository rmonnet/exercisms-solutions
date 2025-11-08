local openingBrackets = { ['('] = true, ['['] = true, ['{'] = true }
local closingBackets = { [')'] = '(', [']'] = '[', ['}'] = '{' }

return {
  valid = function(s)

    local tokens = {}
    for c in s:gmatch(".") do
      if openingBrackets[c] then
        table.insert(tokens, c)
      elseif closingBackets[c] then
        if table.remove(tokens) ~= closingBackets[c] then
          return false
        end
      end

    end
    return #tokens == 0

  end
}
