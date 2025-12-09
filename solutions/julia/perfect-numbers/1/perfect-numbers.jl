function isperfect(n)
    return n == aliquot_sum(n)
end

function isabundant(n)
    return n < aliquot_sum(n)
end

function isdeficient(n)
    return n > aliquot_sum(n)
end

function aliquot_sum(n)
    if n < 1
        throw(DomainError(n, "Not a natural number"))
    end
    sum = 0
    for i in 1:n-1
        if n % i == 0
            sum += i
        end
    end
    sum
end