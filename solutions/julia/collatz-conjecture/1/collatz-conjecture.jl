function collatz_steps(n)

    if n < 1
        throw(DomainError(n, "N must be an integer"))
    end
    
    steps = 0
    while n != 1
        if n % 2 == 0
            n = div(n,  2)
        else
            n = 3n + 1
        end
        steps += 1
    end
    steps
end
