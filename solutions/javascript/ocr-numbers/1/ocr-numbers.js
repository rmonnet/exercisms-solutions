
const NUMBERS = {
  '     |  |   ': 1, ' _  _||_    ': 2, ' _  _| _|   ': 3, '   |_|  |   ': 4, 
  ' _ |_  _|   ': 5, ' _ |_ |_|   ': 6, ' _   |  |   ': 7, ' _ |_||_|   ': 8,
  ' _ |_| _|   ': 9, ' _ | ||_|   ': 0};

export function convert(image) {

  // Each number 'image' is spread on 4 lines, we will combines the 4 lines into 1
  // and store each one-liner number 'image' in NUMBERS so we can easily match them. 
  
  let lines = image.split('\n');
  let result = '';
  // we may have multiple numbers, each number is represented on 4 lines.
  for (let n = 0; n < lines.length; n += 4) {
    
    // separate the numbers with commas
    if (n > 0) result += ',';

    // Each number may have multiple digits, each digit is 3 columns wide.
    // Combine each digit into a single line.
    let digits = [];
    for (let i = 0; i < lines[0].length; i += 3) {
      let digit = '';
      for (let j = n; j < n+4; j++) digit += lines[j].slice(i,i+3);
      digits.push(digit)
    }

    // Now lookup each digit 'image' in NUMBERS, including the case where the digit is not
    // recognizable.
    for (const digit of digits) {
      if (digit in NUMBERS) {
        result += NUMBERS[digit];
      } else {
        result += '?';
      }
    }
  }
  return result;
};
