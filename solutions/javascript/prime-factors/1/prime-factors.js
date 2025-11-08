// Returns the list of primes smaller or equal to n.
function primes(n) {

  if (n < 2) return [];

  // Accumulate the list of known primes in 'primes'.
  // We know 2 is the only even number that is prime.
  // Go through the odd numbers between 3 and n and test if they
  // are divisible by any of the already found primes. If they are
  // not, then add to the list of know primes.
  
  const primes = [2];

  for (let candidate = 3; candidate <= n; candidate += 2) {
    let divisorFound = false;
    for (const prime of primes) {
      if (candidate % prime == 0) {
        divisorFound = true;
        break;
      }
    }
    if (!divisorFound) primes.push(candidate);
  }
  return primes;
}

// Returns the list of primeFactors for n.
export function primeFactors(n) {

  // All prime factors must be lower than sqrt(n) (except for the last one)
  const possibleFactors = primes(Math.trunc(Math.sqrt(n)))
  let factors = [];
  for (const f of possibleFactors) {
    while (n % f == 0) {
      factors.push(f)
      n /= f
    }
  }
  // What ever remain is the last prime factor.
  if (n > 1) factors.push(n);
  return factors;
}