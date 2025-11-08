local School = {}
School.__index = School

function School:new()

    local res = {}
    res._roster = {}
    setmetatable(res, self)

    return res
end

function School:roster()

    return self._roster
end

function School:add(student, grade)

    if not self._roster[grade] then
        self._roster[grade] = {}
    end

    table.insert(self._roster[grade], student)
    table.sort(self._roster[grade])
end

function School:grade(n)

    return self._roster[n] or {}
end

return School
