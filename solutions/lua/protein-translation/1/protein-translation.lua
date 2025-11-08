local PROTEINS = {
  AUG = 'Methionine',
  UUU = 'Phenylalanine',
  UUC = 'Phenylalanine',
  UUA = 'Leucine',
  UUG = 'Leucine',
  UCU = 'Serine',
  UCC = 'Serine',
  UCA = 'Serine',
  UCG = 'Serine',
  UAU = 'Tyrosine',
  UAC = 'Tyrosine',
  UGU = 'Cysteine',
  UGC = 'Cysteine',
  UGG = 'Tryptophan',
  UAA = 'STOP',
  UAG = 'STOP',
  UGA = 'STOP',
}

local function translate_codon(codon)

  return assert(PROTEINS[codon], 'Unknown Codon')
end

local function translate_rna_strand(rna_strand)

  local proteins = {}

  for codon in string.gmatch(rna_strand, '%a%a%a') do
    local protein = translate_codon(codon)
    if protein == 'STOP' then break end
    proteins[#proteins + 1] = protein
  end

  return proteins
end

return {
  codon = translate_codon,
  rna_strand = translate_rna_strand
}
