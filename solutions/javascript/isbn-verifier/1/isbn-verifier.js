

export function isValid(isbn) {

  // Validate applies the formula to the ISBN 9 digits and bonus digit.
  const validate = function([x1, x2, x3, x4, x5, x6, x7, x8, x9, x10]) {
    const formula = (x1 * 10 + x2 * 9 + x3 * 8 + x4 * 7 + x5 * 6 + x6 * 5 + x7 * 4 + x8 * 3 + x9 * 2 + x10 * 1);
    return (formula % 11 == 0);
  }

  // parseDigit parse the digits string (0 to 9 and X) into numbers.
  const parseDigit = function(d) {
    if (d == 'X') return 10;
    return Number.parseInt(d);
  } 

  // Remove the hyphens, check the number is 9 digits followed by a digit or X
  // and then check it.
  let cleanedUpIsbn = isbn.replace(/-/g, '');
  if (! /^[0-9]{9}[0-9X]$/.test(cleanedUpIsbn)) return false;

  return validate(cleanedUpIsbn.split('').map(d => parseDigit(d)));
  
};
