local function letters(word)

    local res = {}

    for letter in word:lower():gmatch('.') do
        res[letter] = (res[letter] or 0) + 1
    end

    return res
end

local function same_letters(set1, set2)

    -- to check if two sets have the same content,
    -- we need to check that each set is a subset of the other one.
    for k, v in pairs(set1) do
        if set2[k] ~= v then
            return false
        end
    end

    for k, v in pairs(set2) do
        if set1[k] ~= v then
            return false
        end
    end

    return true
end

local Anagram = {}
Anagram.__index = Anagram

function Anagram:new(word)

    local res = {}
    res.letters = letters(word)
    setmetatable(res, self)

    return res
end

function Anagram:match(words)

    local res = {}

    for _, word in ipairs(words) do
        if same_letters(self.letters, letters(word)) then
            table.insert(res, word)
        end
    end

    return res
end

return Anagram
