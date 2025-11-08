
export function clean(number) {

  // Clean up by removing () - . and space.
  // Remove the leading 1 for an 11 digits number.
  // Check the resulting number is 10 digits long.
  // Also check 1st and 4th digits  are not '1'.
  
  number = number.replace(/[ +().-]/g, '')
  
  if (number.match(/[a-zA-z]/)) throw new Error('Letters not permitted')
  if (number.match(/[@:!]/)) throw new Error('Punctuations not permitted')
  if (number.length > 11) throw new Error('More than 11 digits')
  if (number.length == 11) {
    if (number.charAt(0) != '1') throw new Error('11 digits must start with 1');
    number = number.slice(1);
  }
  if (number.length != 10) throw new Error('Incorrect number of digits');
  if (number.charAt(0) == '0') throw new Error('Area code cannot start with zero');
  if (number.charAt(0) == '1') throw new Error('Area code cannot start with one');
  if (number.charAt(3) == '0') throw new Error('Exchange code cannot start with zero');
  if (number.charAt(3) == '1') throw new Error('Exchange code cannot start with one');

  return number;
};
