/*
From: https://en.wikipedia.org/wiki/Pythagorean_triple

Primitive Pythagorean Triples can all be generated from a pair of integers (m, n) with

- a = k * (m^2 - n^2)
- b = k * (2 * m * n)
- c = k * (m^2 + n^2)
- 0 < n < m
- m and n must be coprime (i.e. gcd(m,n) == 1)

Working with k =1 for now:

We are looking for a triple such that the sum is N
- N = a + b + c = 2 * m * (m + n) 
- from n being positive we can also deduct 2 * m^ 2 < N and therefore (2a) m < sqrt(N / 2)
- given N and m, (1) n = N / (2 * m) - m
- and from n < m, we can deduct N / (2 * m) - m < m and therefore m > sqrt(N) / 2 or (2b) sqrt(N) / 2 < m

We can then reduce the search space to:
- m such that sqrt(N)/2 < m < sqrt(N/2) (from (2a) and (2b))
- n = N/(2*m)-m (from (1))
- n must be an integer

Extending to other values of k, if the triple sum is N/k, then a solution of the original problem
is the triple solution of the N/k problem multiplied by k.

- 2 <= k <= N/12 (we need N/k to be at least 12, since (3,4,5) is the smallest triple)
- N/k must be an integer
- use the solutions of the N/k problem (multiplying by k)
*/

// Checks if the number is an integer.
function isInteger(n) {
  return (n == Math.trunc(n));
}

// Computes all the Pythagorean Triplets for which the sum of factors equals sum
// and, if specified, the factors are between minFactor and maxFactor.
export function triplets({ minFactor, maxFactor, sum }) {

  // This algorithm may finds duplicate solutions (for different values of k).
  // Use a map so we can easily check for existing solutions.
  let solutions = new Map();

  // Check all k values until the sumOverK is reduces to 12 (smallest known triplet).
  for (let k = 1; k <= sum/12; k++) {

    let sumOverK = sum / k;
    if (!isInteger(sumOverK)) continue;
    
    let m0 = Math.ceil(Math.sqrt(sumOverK)/2);
    let m1 = Math.sqrt(sumOverK/2);

    // Checks the m between sqrt(sum/k)/2 and sqrt (sum/k/2)
    // for values of n that are integers smaller than m.
    for (let m = m0; m < m1; m++) {
      let n = sumOverK / (2 * m) - m;
      if (!isInteger(n) || n >= m) continue;
      let a = k * (m * m - n * n);
      let b = k * (2 * m * n);
      let c = k * (m * m + n * n);
      let solution = new Triplet(a, b, c);
      if (solutions.has(solution.key)) continue;
      if (minFactor != null && solution.minFactor < minFactor) continue;
      if (maxFactor != null && solution.maxFactor > maxFactor) continue;
      solutions.set(solution.key, solution);
    }
  }

  // need to sort the results to match the test expected results
  let result = Array.from(solutions.values()).sort((a,b) => a.key - b.key);
  return result;
}

// Triplet is a helper class to present the solutions.
class Triplet {
  
  constructor(a, b, c) {
    this.triplet = [a, b, c].sort((x, y) => x - y);
  }

  get key() {
    return this.triplet[0];
  }

  get minFactor() {
    return this.triplet[0];
  }

  get maxFactor() {
    return this.triplet[2];
  }

  toArray() {
    return this.triplet;
  }
}
