-- Letters converts the word to lowercase and sort alphanumerically
-- to create a signature of the word.
local function letters(word)

    local res = {}

    for letter in word:lower():gmatch('.') do
        table.insert(res, letter)
    end

    table.sort(res)

    return table.concat(res)
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
        if self.letters == letters(word) then
            table.insert(res, word)
        end
    end

    return res
end

return Anagram
