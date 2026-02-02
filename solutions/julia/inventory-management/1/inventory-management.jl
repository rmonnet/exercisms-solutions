create_inventory(items) = add_items(Dict(), items)

function add_items(inventory, items)
    for item in items
        if !(item in keys(inventory))
            inventory[item] = 0
        end
        inventory[item] += 1
    end
    return inventory
end

function decrement_items(inventory, items)
    for item in items
        if item in keys(inventory) && inventory[item] > 0
            inventory[item] -= 1
        end
    end
    return inventory
end

remove_item(inventory, item) = delete!(inventory, item)

function list_inventory(inventory)
    list = []
    for key in sort(collect(keys(inventory)))
        if inventory[key] > 0
            push!(list, Pair(key, inventory[key]))
        end
    end
    return list
end
