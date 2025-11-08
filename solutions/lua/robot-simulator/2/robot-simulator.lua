--[[
Write a robot simulator.

A robot factory's test facility needs a program to verify robot movements.

The robots have three possible movements:

- turn right
- turn left
- advance

Robots are placed on a hypothetical infinite grid, facing a particular
direction (north, east, south, or west) at a set of {x,y} coordinates,
e.g., {3,8}, with coordinates increasing to the north and east.

The robot then receives a number of instructions, at which point the
testing facility verifies the robot's new position, and in which
direction it is pointing.

- The letter-string "RAALAL" means:
  - Turn right
  - Advance twice
  - Turn left
  - Advance once
  - Turn left yet again
- Say a robot starts at {7, 3} facing north. Then running this stream
  of instructions should leave it at {9, 4} facing west.

]]

local Robot = {}
Robot.__index = Robot

Robot.advance = {
    north = { dir = 'y', step = 1 },
    east = { dir = 'x', step = 1 },
    south = { dir = 'y', step = -1 },
    west = { dir = 'x', step = -1 }
}

Robot.turn_right = {
    north = 'east',
    east = 'south',
    south = 'west',
    west = 'north'
}


Robot.turn_left = {
    north = 'west',
    east = 'north',
    south = 'east',
    west = 'south'
}

function Robot:move(commands)

    for command in commands:gmatch('.') do
        if command == 'A' then
            local advance = self.advance[self.heading]
            self[advance.dir] = self[advance.dir] + advance.step
        elseif command == 'R' then
            self.heading = self.turn_right[self.heading]
        elseif command == 'L' then
            self.heading = self.turn_left[self.heading]
        else
            error("Unknown command: '" .. command .. "'")
        end
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
