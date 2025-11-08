local function normalized_plaintext(plaintext)

  return plaintext:gsub('%W', ''):lower()
end

local function size(plaintext)

  local text = normalized_plaintext(plaintext)
  local ncols = math.ceil(math.sqrt(text:len()))
  local nrows = math.ceil(text:len() / ncols)

  return ncols, nrows
end

local function segments(plaintext)

  local text = normalized_plaintext(plaintext)
  local ncols, nrows = size(plaintext)
  local res = {}
  for i = 1, nrows do
    local offset = (i - 1) * ncols + 1
    table.insert(res, text:sub(offset, offset + ncols - 1))
  end

  return res
end

local function ciphertext(plaintext)

  local chunks = segments(plaintext)
  local nrows = #chunks
  local ncols = #chunks[1]

  local res = {}
  for c = 1, ncols do
    for r = 1, nrows do
      table.insert(res, chunks[r]:sub(c, c))
    end
  end

  return table.concat(res)
end

local function normalized_ciphertext(plaintext)

  local cipher = ciphertext(plaintext)
  local ncols, nrows = size(plaintext)

  local res = {}
  local delta = nrows * ncols - cipher:len()
  local offset = 1
  for c = 1, ncols do
    local chunk_len = (c <= ncols - delta) and nrows or (nrows - 1)
    res[c] = cipher:sub(offset, offset + chunk_len - 1)
    offset = offset + chunk_len
  end

  return table.concat(res, ' ')
end

return {
  normalized_plaintext = normalized_plaintext,
  size = size,
  segments = segments,
  ciphertext = ciphertext,
  normalized_ciphertext = normalized_ciphertext
}
