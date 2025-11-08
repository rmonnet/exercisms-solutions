--[[
The data structure used for the tree node has two elements:
- the first element is the node name
- the second element is the set of the node children
- the second element is absent (equiv. to nil) if there are no children
]]

-- NodeName returns the name of the node.
local function nodeName(tree)

  return tree[1]
end

-- NodeChildren returns the set of childrens for the node
-- or the empty set if there are no children.
local function nodeChildren(tree)

  return tree[2] or {}
end

-- arrayOf returns a new array with all the values in the original array
-- plus value. The new array is independent from the original array
-- (both can be modified independently).
local function arrayOf(array, value)

  local res = { table.unpack(array or {}) }
  table.insert(res, value)

  return res
end

-- Nodes returns an iterator to an array of pairs (node_name, indexes to node_name)
-- for each node in the tree. The indexes provides a way to navigate to the node from
-- the top of the tree. The root of the tree is not part of the solution.
local function nodes(tree, path)

  return coroutine.wrap(function()

    if path then
      coroutine.yield({ nodeName(tree), path })
    end

    for i, child in ipairs(nodeChildren(tree)) do
      local new_path = arrayOf(path, i)
      for v in nodes(child, new_path) do
        coroutine.yield(v)
      end
    end
  end)
end

-- NodeSwap swaps the parent and its children (minus child #n) with child #n and its own children
-- the 'old' parent is put at the end of child #n children list.
-- we want the function to be immutable, that is return a new tree without modifying the original one.
local function nodeSwap(tree, n)

  local child_n = nodeChildren(tree)[n]
  local new_children = {}

  -- first add the children of child #n
  for i, child in ipairs(nodeChildren(child_n)) do
    new_children[i] = child
  end

  -- then add the old parent and its children minus child #n
  local old_parent_children = {}
  for i, child in ipairs(nodeChildren(tree)) do
    if i ~= n then
      table.insert(old_parent_children, child)
    end
  end

  if #old_parent_children > 0 then
    table.insert(new_children, { nodeName(tree), old_parent_children })
  else
    table.insert(new_children, { nodeName(tree) })
  end

  return { nodeName(child_n), new_children }
end

-- Path returns the list of nodes to navigate from the top of the
-- tree to the target node. The path is added to the existing currentPath.
local function path(tree, target, current_path)

  local new_path = arrayOf(current_path, nodeName(tree))
  if nodeName(tree) == target then
    return new_path
  end

  for _, child in ipairs(nodeChildren(tree)) do
    local full_path = path(child, target, new_path)
    if full_path then
      return full_path
    end
  end
  return nil
end

-- PovFrom returns a new tree where the node with node_name has been swapped with the root
-- of the tree. It returns an error if node_name is not in the tree.
local function povFrom(node_name)

  local res = {}

  function res.of(tree)

    -- Trivial case where node_name is already the root of the tree.
    if nodeName(tree) == node_name then
      return tree
    end

    -- Find a path to node_name from the root and then
    -- swap node_name and the current root.
    for path in nodes(tree) do
      if path[1] == node_name then
        local new_tree = tree
        for _, n in ipairs(path[2]) do
          new_tree = nodeSwap(new_tree, n)
        end
        return new_tree
      end
    end
    error("can't find " .. node_name .. " in tree")
  end

  return res
end

-- pathFrom returns the set of node names forming a path from source
-- to target.
local function pathFrom(source)

  local res = {}

  function res.to(target)

    local res = {}

    function res.of(tree)

      local sourceTree = povFrom(source).of(tree)
      assert(sourceTree, "can't find source in tree")
      return assert(path(sourceTree, target), "can't find target in tree")
    end

    return res
  end

  return res

end

return {
  pov_from = povFrom,
  path_from = pathFrom
}
