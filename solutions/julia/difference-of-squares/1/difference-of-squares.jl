"Square the sum of the first `n` positive integers"
function square_of_sum(n)
    sum = div(n * (n+1),  2)
    return sum*sum
end

"Sum the squares of the first `n` positive integers"
function sum_of_squares(n)
    return div(n * (n+1) * (2n+1), 6)
end

"Subtract the sum of squares from square of the sum of the first `n` positive ints"
function difference(n)
    return square_of_sum(n) - sum_of_squares(n)
end
