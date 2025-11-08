local NUCLEOTIDES = { 'A', 'C', 'T', 'G' }

local DNA = {}
DNA.__index = DNA

function DNA:new(dna_string)

    if not string.match(dna_string, '^[ACTG]*$') then
        error('Invalid Sequence')
    end

    local res = {}
    setmetatable(res, DNA)
    res.nucleotideCounts = {}
    for _, nucleotide in ipairs(NUCLEOTIDES) do
        res.nucleotideCounts[nucleotide] = select(2, string.gsub(dna_string, nucleotide, ''))
    end
    return res
end

function DNA:count(nucleotide)
    return self.nucleotideCounts[nucleotide] or error('Invalid Nucleotide')
end

return DNA