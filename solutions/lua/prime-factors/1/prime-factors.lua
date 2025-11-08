--[[
Primes smaller than n are numbers up to sqrt(n).

We could use a prime generator to capture all the primes smaller than n
and then test to see which one are divisors of n but this will be slow in lua
for large value of n because of the prime array construction and manipulation.

If instead we try all numbers between 2 and sqrt(n) against n or its remainder (once divided
by previously found prime factors) we will get the same result. All divisions by non-prime will fails
to be exact division as the remainder at this stage has already been divided by the factors of the
non-prime numbers.

We can further optimize by skipping all even numbers greater than 2
]]
return function(n)

    local factors = {}

    -- find how many times 2 is a prime factor
    while n % 2 == 0 do
        table.insert(factors, 2)
        n = n / 2
    end

    -- for each odd number up to sqrt(n) find how many times they are prime factors
    for i = 3, math.sqrt(n), 2 do
        while n % i == 0 do
            table.insert(factors, i)
            n = n / i
        end
    end

    -- if there is any remainder, it is itself a prime factor
    if n > 2 then
        table.insert(factors, n)
    end

    return factors
end
