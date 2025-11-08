local DNA_TO_RNA = {
    G = 'C',
    C = 'G',
    T = 'A',
    A = 'U'
}

return function(dna_strand)

    local rna_strand = {}
    for i, dna in ipairs { string.byte(dna_strand, 1, -1) } do
        rna_strand[i] = DNA_TO_RNA[string.char(dna)]
    end

    return table.concat(rna_strand, '')
end
