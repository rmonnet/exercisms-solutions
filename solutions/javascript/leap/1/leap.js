
function isEvenlyDivisible(n, m) {
  return (n % m) == 0;
}

// Checks if the given year is a leap year.
export function isLeap(year) {
  
  // A year is a leap year if
  // - it is evenly divisible by 4
  // - it is not evenly divisible by 100 unless it is also evenly divisible by 400
  return isEvenlyDivisible(year, 4) && (!isEvenlyDivisible(year, 100) || isEvenlyDivisible(year, 400));
};
