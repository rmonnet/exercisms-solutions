function time_to_mix_juice(juice)
    if juice == "Pure Strawberry Joy"
        return 0.5
    elseif juice == "Energizer" || juice == "Green Garden"
        return 1.5
    elseif juice == "Tropical Island"
        return 3
    elseif juice == "All or Nothing"
        return 5
    else
        return 2.5
    end
end

function wedges_from_lime(size)
    if size == "small"
        return 6
    elseif size == "medium"
        return 8
    elseif size == "large"
        return 10
    end
end

function limes_to_cut(needed, limes)
    if needed == 0
        return 0
    end
    num_limes = 0
    num_wedges = 0
    for lime in limes
        num_limes += 1
        num_wedges += wedges_from_lime(lime)
        if num_wedges >= needed
            return num_limes
        end
    end
    return num_limes
end

function order_times(orders)
    times = Float64[]
    for order in orders
        push!(times, time_to_mix_juice(order))
    end
    times
end

function remaining_orders(time_left, orders)
    if time_left == 0
        return orders
    end
    while length(orders) > 0
        order = popfirst!(orders)
        time_left -= time_to_mix_juice(order)
        if time_left <= 0
            return orders
        end
    end
    return orders
end
