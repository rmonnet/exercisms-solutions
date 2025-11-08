local Clock = {}
Clock.__index = Clock

function Clock.at(hours, minutes)

    local minutes = minutes or 0

    local time = {}
    setmetatable(time, Clock)
    local h = minutes // 60
    time.minutes = minutes - h * 60
    time.hours = (hours + h) % 24

    return time
end

function Clock:plus(minutes)

    return Clock.at(self.hours, self.minutes + minutes)

end

function Clock:equals(other)

    return self.hours == other.hours and self.minutes == other.minutes
end

function Clock:minus(minutes)

    -- the constructor 'at' can deal with negative hours but not negative minutes
    -- if the number of minutes is negative, switch to the previous hour
    local remaining_minutes = self.minutes - minutes
    local hours = self.hours
    while remaining_minutes < 0 do
        remaining_minutes = remaining_minutes + 60
        hours = hours - 1
    end

    return Clock.at(hours, remaining_minutes)

end

function Clock:__tostring()
    return string.format('%02d:%02d', self.hours, self.minutes)
end

return Clock
