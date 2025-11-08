local DNA = {}
DNA.__index = DNA

function DNA:new(dna_string)

    if not string.match(dna_string, '^[ACTG]*$') then
        error('Invalid Sequence')
    end

    local res = {}
    setmetatable(res, DNA)
    res.nucleotideCounts = { A = 0, T = 0, C = 0, G = 0 }
    for _, char in ipairs { string.byte(dna_string, 1, -1) } do
        local nucleotide = string.char(char)
        res.nucleotideCounts[nucleotide] = res.nucleotideCounts[nucleotide] + 1
    end
    return res
end

function DNA:count(nucleotide)
    local res = self.nucleotideCounts[nucleotide]
    if not res then
        error('Invalid Nucleotide')
    end
    return res
end

return DNA
