// Checks if a number (like a credit card) is a valid number according to the Luhn formula.
export function valid(number) {

  // we could compact some of the steps, but it is easier to understand this way.

  // cleanup spaces from the number string
  const step0 = number.replace(/ /g, '');
  
  // numbers with less than 2 digits are invalid
  if (step0.length <= 1) return false;

  // now convert the number string into an array of digits
  // we will reverse the array to simplify the next step
  const step1 = step0.split('').reverse().map(d => Number.parseInt(d))
  
  // double every single digit starting from the left (since we reversed the array)
  // if doubled digits are greater than 9, subtract 9
  const step2 = step1.map((digit, index) => {
    if (index % 2 == 1) {
      let doubleDigit = 2 * digit;
      if (doubleDigit > 9) doubleDigit -= 9;
      return doubleDigit;
    } else {
      return digit;
    }});

  // sum all the digits and check is the result is divisible by 10
  const step3 = step2.reduce((sum,digit) => sum+digit);
  return (step3 % 10 == 0);
};
