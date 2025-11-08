return function(dna)

    return dna:gsub('%a', { G = 'C', C = 'G', T = 'A', A = 'U' })
end