-- factors compute all factors of n
-- a factor of n is any number greater than 0 and lower than n which is a perfectdivisor of n
local function factors(n)

  if n == 1 then return {} end

  local fs = { 1 }
  for f = 2, n - 1 do
    if n % f == 0 then
      table.insert(fs, f)
    end
  end

  return fs

end

local function aliquot_sum(n)

  local res = 0
  for _, v in ipairs(factors(n)) do
    res = res + v
  end

  return res

end

local function classify(n)

  local sum = aliquot_sum(n)
  if sum == n then
    return 'perfect'
  elseif sum > n then
    return 'abundant'
  else
    return 'deficient'
  end
end

return {
  aliquot_sum = aliquot_sum,
  classify = classify
}
