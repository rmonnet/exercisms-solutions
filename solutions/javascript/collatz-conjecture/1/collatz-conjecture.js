// Computes the number of steps to reach 1 from n using the Collatz conjuncture.
// Throws an error if this is not possible.
export function steps(n) {
  
  // Collatz conjuncture:
  // - Take any positive integer n.
  // - If n is even, divide n by 2 to get n / 2.
  // - If n is odd, multiply n by 3 and add 1 to get 3n + 1.
  // - Repeat the process indefinitely.
  // The conjecture states that no matter which number you start with, you will always reach 1 eventually.

  let steps = 0;
  
  while (true) {
  
    if (n <= 0 || n != Math.trunc(n)) {
      throw new Error('Only positive numbers are allowed');
    }

    if (n == 1) return steps;
    
    steps++;
    n = (n % 2 == 0) ? n / 2 : 3 * n + 1;
  }
};
