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

local function to_list(tree, acc)

    if tree == nil then return acc end
    to_list(tree.left, acc)
    table.insert(acc, tree.value)
    to_list(tree.right, acc)
end

function BinarySearchTree:values()

    local list = {}
    to_list(self, list)
    local i = 0
    return function()
        i = i + 1
        if i <= #list
        then return list[i]
        end
    end
end

return BinarySearchTree
