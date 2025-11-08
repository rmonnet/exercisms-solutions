local function parent(tree)
  return tree[1]
end

local function children(tree)
  return tree[2]
end

-- Swap swaps the parent and its children (minus child #n) with child #n and its own children
-- the 'old' parent is put at the end of child #n children list.
-- we want the function to be immutable, that is return a new tree without modifying the original one.
local function swap(tree, n)

  local childN = children(tree)[n]
  local newChildren = {}
  -- first add the children of child #n
  for i, child in ipairs(children(childN) or {}) do
    newChildren[i] = child
  end
  -- then add the old parent and its children minus child #n
  local oldParentChildren = {}
  for i, child in ipairs(children(tree)) do
    if i ~= n then
      table.insert(oldParentChildren, child)
    end
  end
  if #oldParentChildren > 0 then
    table.insert(newChildren, { parent(tree), oldParentChildren })
  else
    table.insert(newChildren, { parent(tree) })
  end
  return { parent(childN), newChildren }
end

local function insert(array, value)
  local res = {}
  if array then
    for i, v in ipairs(array) do
      res[i] = v
    end
  end
  table.insert(res, value)
  return res
end

local function path(tree, target, currentPath)

  local newPath = insert(currentPath, parent(tree))
  if parent(tree) == target then
    return newPath
  end
  for _, child in ipairs(children(tree) or {}) do
    local solution = path(child, target, newPath)
    if solution then
      return solution
    end
  end
  return nil
end

local function pov_from(node_name)

  local res = {}
  function res.of(tree)
    if parent(tree) == node_name then
      return tree
    end
    for i = 1, #children(tree) do
      local newTree = swap(tree, i)
      if parent(newTree) == node_name then
        return newTree
      end
      if #children(newTree) > 1 then
        local solution = res.of(newTree)
        if solution then
          return solution
        end
      end
    end
    return {}
  end

  return res
end

local function path_from(source)

  local res = {}
  function res.to(target)
    local res = {}
    function res.of(tree)
      local sourceTree = pov_from(source).of(tree)
      assert(sourceTree, "can't find source in tree")
      return assert(path(sourceTree, target), "can't find target in tree")
    end

    return res
  end

  return res

end

return {
  swap = swap,
  pov_from = pov_from,
  path_from = path_from
}
