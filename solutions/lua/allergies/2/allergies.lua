local ALLERGIES = {
  "eggs",
  "peanuts",
  "shellfish",
  "strawberries",
  "tomatoes",
  "chocolate",
  "pollen",
  "cats",
}

-- stores the score for each allergy to avoid recomputing
local SCORES = {}
for i, allergy in ipairs(ALLERGIES) do
  SCORES[allergy] = 2 ^ (i - 1)
end

local function list(score)
  local res = {}
  for _, allergy in ipairs(ALLERGIES) do
    if (score & SCORES[allergy]) == SCORES[allergy] then
      table.insert(res, allergy)
    end
  end
  return res
end

local function allergic_to(score, which)
  return (score & SCORES[which]) == SCORES[which]
end

return {
  list = list,
  allergic_to = allergic_to
}
