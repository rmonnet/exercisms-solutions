// Javascript integers are not reliable above 1^53.
// Also Javascript shift operators provides results as signed 32 bits integers.
// So we will be using Javascript BigInt for this exercise.
// BigInt literals use the suffix 'n'.
// The result for the ith square is 2 to the (i-1) power.
// We can use the power '**' operation or the shift '<<' operation,
// the shift operation is more efficient.

// Returns the number of grains on the ith square.
// The number starts with 1 grain and double on each square.
export function square(i) {

  if (i < 1 || i > 64) throw new Error('square must be between 1 and 64');
  
  // The number of grain on each square is a power of two
  // 2^(i-1) (since we start with 1=2^0 on square 1).
  // We also use the fact that 2^n = 1 << n.
  
  return (1n << (BigInt(i)-1n)).toString();
};

// Compute the total number of grains on the board.
export const total = () => {
  
  // We could just sum all the squares from 1 to 64 but it is faster to apply
  // the formula for the sum of the first n powers of 2.
  // 2^0 + 2^1 + 2^2 + ... + 2^n = 2^(n+1) -1
  // which we can implement with the shift operator as 2^n = 1 << n.
  
  return ((1n << 64n) - 1n).toString();
};
