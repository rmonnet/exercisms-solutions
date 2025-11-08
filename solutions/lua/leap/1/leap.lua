local leap_year = function(number)

    -- a leap year is evenly divisible by 4
    -- but not that is evenly divisible by 100
    -- unless it is is also evenly divisible by 400
    return (number % 4 == 0) and ((number %100 ~= 0) or (number % 400 == 0))
end

return leap_year
