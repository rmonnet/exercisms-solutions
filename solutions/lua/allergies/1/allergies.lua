--[[
  Lua doesn't have bitwise and operators so we can't use the obviosu solution using masks.
  We can go through allergies from highest to lowest score:
    - if the score is higher or equal then the allergy is in the list
    - if it is in the list, we need to remove it before checking the next one.
]]

local ALLERGIES = {
  "cats",
  "pollen",
  "chocolate",
  "tomatoes",
  "strawberries",
  "shellfish",
  "peanuts",
  "eggs",
}

local function list(score)
  -- since we don't have proper mask, limits the values to the first 8 bits
  score = score % 256
  local allergy_score = math.floor(2 ^ (#ALLERGIES - 1))
  local res = {}
  for _, allergie in ipairs(ALLERGIES) do
    if math.floor(score / allergy_score) == 1 then
      table.insert(res, 1, allergie)
      score = score - allergy_score
    end
    allergy_score = math.floor(allergy_score / 2)
  end
  return res
end

local function allergic_to(score, which)
  local allergies = list(score)
  for _, allergie in ipairs(allergies) do
    if allergie == which then return true end
  end
  return false
end

return {
  list = list,
  allergic_to = allergic_to
}
