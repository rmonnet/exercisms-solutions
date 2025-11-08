
// Computes all the factors of n.
// A factor of n is any number lower than n which is a perfect divisor.
function factors(n) {
  
    if (n ==1) return [];
  
  let factors = [1];
    for (let f = 2; f < n; f++) {
        if (n % f == 0) factors.push(f)
    }
    return factors;
}

// Returns the sum of the elements of an array.
const sum = (array) => array.reduce((acc,val) => acc+val, 0); 

// Classifies n as perfact, abundant or deficient.
export function classify(n) {
  
  if (n <= 0 || Math.trunc(n) != n) {
    throw new Error('Classification is only possible for natural numbers.');
  }

  let aliquotSum = sum(factors(n));

  if (aliquotSum == n) return 'perfect';
  if (aliquotSum > n) return 'abundant';
  return 'deficient';
};
