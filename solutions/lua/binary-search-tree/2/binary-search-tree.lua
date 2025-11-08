local BinarySearchTree = {}

function BinarySearchTree:new(value)

    local res = { value = value }
    BinarySearchTree.__index = BinarySearchTree
    setmetatable(res, BinarySearchTree)
    return res
end

function BinarySearchTree:insert(value)
    if value <= self.value then
        if self.left then
            self.left:insert(value)
        else
            self.left = BinarySearchTree:new(value)
        end
    else -- value > self.value
        if self.right then
            self.right:insert(value)
        else
            self.right = BinarySearchTree:new(value)
        end
    end
end

function BinarySearchTree:from_list(list)

    assert(#list > 0, 'Can\'t create a BinarySearchTree from an empty list')

    local res = BinarySearchTree:new(list[1])
    for i = 2, #list do
        res:insert(list[i])
    end

    return res
end

function BinarySearchTree:values()

    return coroutine.wrap(function()
        if self.left then
            for v in self.left:values() do
                coroutine.yield(v)
            end
        end
        coroutine.yield(self.value)
        if self.right then
            for v in self.right:values() do
                coroutine.yield(v)
            end
        end
    end)
end

return BinarySearchTree
