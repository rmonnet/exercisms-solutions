get_vector_of_wagons(args...) = collect(args)

fix_vector_of_wagons(each_wagons_id, missing_wagons) = get_vector_of_wagons(
    each_wagons_id[3], missing_wagons..., each_wagons_id[4:end]...,  
    each_wagons_id[1:2]...)

add_missing_stops(route, stops...) = Dict(
        "from" => route["from"],
        "to" => route["to"],
        "stops" => collect(map(stop -> stop.second, stops)))

function extend_route_information(route; more_route_information...)
    extended_route = Dict{Any, String}(route)
    for extra in more_route_information
        extended_route[extra.first] = extra.second
    end
    return extended_route
end
