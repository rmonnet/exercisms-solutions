local function randDigit()
    return math.random(1,9)
end

local function randLetter()
    return string.char(math.random(1, 26) + string.byte('A'))
end

local Robot = {}

function Robot:new()
    local res = {}
    setmetatable(res, Robot)
    Robot.__index = Robot
    res.name = table.concat{randLetter(), randLetter(), randDigit(), randDigit(), randDigit()}
    return res
end

function Robot:reset()
    local newName = self.name
    while newName == self.name do
        newName = table.concat{randLetter(), randLetter(), randDigit(), randDigit(), randDigit()}
    end
    self.name = newName
end

return Robot
