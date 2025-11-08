let leap_year n =
    let is_multiple_of m = (n mod m) = 0 in
    is_multiple_of 4 && (not (is_multiple_of 100) || is_multiple_of 400)
