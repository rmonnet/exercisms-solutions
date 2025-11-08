--[[
    We choose to represent a Set as a lua table where the values of the Set
    are keys and their (arbitrary) value is true.
    We can add duplicate to the set easily (no change to their value).
]]

local Set = {}
Set.__index = Set

function Set:is_empty()
    for _, _ in pairs(self.content) do
        return false
    end
    return true
end

function Set:contains(v)
    return self.content[v] ~= nil
end

function Set:add(v)
    self.content[v] = true
end

function Set:is_subset(s)
    for k, _ in pairs(self.content) do
        if not s:contains(k) then
            return false
        end
    end
    return true
end

function Set:intersection(s)
    local res = Set.new()
    for k, _ in pairs(self.content) do
        if s:contains(k) then
            res:add(k)
        end
    end
    return res
end

function Set:difference(s)
    -- difference set contains elements that are in self but not in s
    local res = Set.new()
    for k, _ in pairs(self.content) do
        if not s:contains(k) then
            res:add(k)
        end
    end
    return res
end

function Set:union(s)
    local res = Set.new()
    for k, _ in pairs(self.content) do
        res:add(k)
    end
    for k, _ in pairs(s.content) do
        res:add(k)
    end
    return res
end

function Set:is_disjoint(s)
    -- disjoint: intersection is empty
    return self:intersection(s):is_empty()
end

function Set:equals(s)
    -- equals = (self is a subset of s) and (s is a subset of self)
    return self:is_subset(s) and s:is_subset(self)
end

function Set.new(...)

    local res = {content = {}}
    setmetatable(res, Set)

    for i, v in ipairs{...} do
        res.content[v] = true
    end
    return res
end

return Set.new
