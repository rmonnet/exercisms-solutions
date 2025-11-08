local function word_count(s)

  local count = {}

  -- remove everything that is not a word, contraction or number
  for token in s:lower():gmatch("[a-z0-9']+") do

    -- take care of the special case where the word is betwen single quotes
    token = token:gsub("^'(.*)'$", "%1")
    if token:match("^[a-z]+$") or token:match("^[a-z]+'[a-z]+$") or token:match("^[0-9]+$") then
      count[token] = (count[token] or 0) + 1
    end
  end

  return count

end

return {
  word_count = word_count,
}
