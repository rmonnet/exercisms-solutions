
const NUCLEOTIDES = {A: 0, C: 1, G: 2, T: 3}

export function countNucleotides(strand) {
  
  let count = [0, 0, 0, 0];
  for (const n of strand) {
    const idx = NUCLEOTIDES[n];
    if (idx === undefined) throw new Error('Invalid nucleotide in strand')
    count[idx]++;
  }
  return count.join(' ');
}
