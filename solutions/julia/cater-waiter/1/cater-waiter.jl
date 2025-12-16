clean_ingredients(dish_name, dish_ingredients) = (dish_name, Set(dish_ingredients))

function check_drinks(drink_name, drink_ingredients)
    if isdisjoint(Set(drink_ingredients), ALCOHOLS)
        return drink_name * " Mocktail"
    else
        return drink_name * " Cocktail"
    end
end

function categorize_dish(dish_name, dish_ingredients)
    ingredients = Set(dish_ingredients)
    if issubset(ingredients, VEGAN)
        return dish_name * ": VEGAN"
    elseif issubset(ingredients, VEGETARIAN)
        return dish_name * ": VEGETARIAN"
    elseif issubset(ingredients, PALEO)
        return dish_name * ": PALEO"
    elseif issubset(ingredients, KETO)
        return dish_name * ": KETO"
    elseif issubset(ingredients, OMNIVORE)
        return dish_name * ": OMNIVORE"
    else
        return dish_name
    end
end

tag_special_ingredients(dish) = (dish[1], intersect(SPECIAL_INGREDIENTS, Set(dish[2])))

function compile_ingredients(dishes)
    all_ingredients = Set()
    for dish in dishes
        all_ingredients = union(all_ingredients, dish)
    end
    return all_ingredients
end

separate_appetizers(dishes, appetizers) = collect(setdiff(Set(dishes), Set(appetizers)))

function singleton_ingredients(dishes, intersection)
    singletons = Set()
    for dish in dishes
        singletons = union(singletons, setdiff(dish, intersection))
    end
    return singletons
end
