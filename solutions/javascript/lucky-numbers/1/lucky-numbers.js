// @ts-check

/**
 * Convert an array of digits to a number.
 */
function digitsToNumber(digits) {
  const multiplier = 10;
  let result = 0;
  for (const digit of digits) {
    result = multiplier * result + digit;
  }
  return result;
}

/**
 * Convert a number to an array of digits.
 */
function numberToDigits(number) {
  let result = [];
  while (number > 0) {
    let digit = number % 10;
    result.unshift(digit);
    number = (number - digit) / 10;
  }
  return result;
}

/**
 * Calculates the sum of the two input arrays.
 *
 * @param {number[]} array1
 * @param {number[]} array2
 * @returns {number} sum of the two arrays
 */
export function twoSum(array1, array2) {
  return digitsToNumber(array1) + digitsToNumber(array2);
}

/**
 * Checks whether a number is a palindrome.
 *
 * @param {number} value
 * @returns {boolean}  whether the number is a palindrome or not
 */
export function luckyNumber(value) {
  let digits = numberToDigits(value);
  while (digits.length > 1) {
    const first = digits.shift();
    const last = digits.pop();
    if (first != last) return false;
  }
  return true;
}

/**
 * Determines the error message that should be shown to the user
 * for the given input value.
 *
 * @param {string|null|undefined} input
 * @returns {string} error message
 */
export function errorMessage(input) {
  if (input === '' || input === null || input === undefined) return 'Required field';
  const number = Number(input);
  if (isNaN(number) || number == 0) return 'Must be a number besides 0'
  return '';
}
