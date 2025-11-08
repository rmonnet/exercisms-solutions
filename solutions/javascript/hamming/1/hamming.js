// Computes the Hamming distance between two strands of DNA.
// The distance is the number of differences in the strands.
// If the strands have a different length, an error is returned.
export function compute(dna1, dna2) {
  
  if (dna1.length != dna2.length) throw new Error('strands must be of equal length');

  let distance = 0;
  for (let i = 0; i < dna1.length; i++) {
    if (dna1.charAt(i) !== dna2.charAt(i)) distance++;
  }
  return distance;
}
