
const CODONS = {
  AUG: 'Methionine',
  UUU: 'Phenylalanine', UUC: 'Phenylalanine',
  UUA: 'Leucine', UUG: 'Leucine',
  UCU: 'Serine', UCC: 'Serine', UCA: 'Serine', UCG: 'Serine',
  UAU: 'Tyrosine', UAC: 'Tyrosine',
  UGU: 'Cysteine', UGC: 'Cysteine',
  UGG: 'Tryptophan',
  UAA: 'STOP', UAG: 'STOP', UGA: 'STOP',
};

export function translate(sequence) {

  if (sequence == null) return [];
  
  let result = [];
  for (let i = 0; i < sequence.length; i += 3) {
    let codon = sequence.slice(i, i+3);
    if (! (codon in CODONS)) throw new Error('Invalid codon');
    if (CODONS[codon] == 'STOP') break;
    result.push(CODONS[codon]);
  }

  return result;
};
