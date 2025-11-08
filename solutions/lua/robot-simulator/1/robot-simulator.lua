local Robot = {}
Robot.__index = Robot

function Robot:move(commands)

    for command in commands:gmatch('.') do
        if command == 'A' then
            self:advance()
        elseif command == 'R' then
            self:turnRight()
        elseif command == 'L' then
            self:turnLeft()
        else
            error("Unknown command: '" .. command .. "'")
        end
    end
end

function Robot:advance()

    if self.heading == 'north' then
        self.y = self.y + 1
    elseif self.heading == 'east' then
        self.x = self.x + 1
    elseif self.heading == 'south' then
        self.y = self.y - 1
    elseif self.heading == 'west' then
        self.x = self.x - 1
    else
        error("Unknown heading '" .. self.heading .. "'")
    end
end

function Robot:turnRight()

    if self.heading == 'north' then
        self.heading = 'east'
    elseif self.heading == 'east' then
        self.heading = 'south'
    elseif self.heading == 'south' then
        self.heading = 'west'
    elseif self.heading == 'west' then
        self.heading = 'north'
    else
        error("Unknown heading '" .. self.heading .. "'")
    end
end

function Robot:turnLeft()

    if self.heading == 'north' then
        self.heading = 'west'
    elseif self.heading == 'east' then
        self.heading = 'north'
    elseif self.heading == 'south' then
        self.heading = 'east'
    elseif self.heading == 'west' then
        self.heading = 'south'
    else
        error("Unknown heading '" .. self.heading .. "'")
    end
end

return function(config)

    local res = {}
    setmetatable(res, Robot)
    res.x = config.x or 0
    res.y = config.y or 0
    res.heading = config.heading or 'north'

    return res
end
