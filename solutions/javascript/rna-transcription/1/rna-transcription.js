
const RNA_COMPLEMENT = {'G': 'C', 'C': 'G', 'T': 'A', 'A': 'U'};

export function toRna(dnaStrand) {
  let result = [];
  for (const nucleotide of dnaStrand) result.push(RNA_COMPLEMENT[nucleotide]);
  return result.join('');
};
