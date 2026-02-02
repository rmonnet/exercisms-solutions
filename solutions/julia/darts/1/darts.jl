function score(x, y)
    d = distance(x, y)
    if d > 10
        return 0
    elseif d > 5
        return 1
    elseif d > 1
        return 5
    else
        return 10
    end
end

distance(x, y) = sqrt(x * x + y * y)