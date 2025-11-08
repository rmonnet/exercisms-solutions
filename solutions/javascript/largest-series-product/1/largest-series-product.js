
const product = (array) => array.reduce((acc, val) => acc*val, 1);
const max = (array) => array.reduce((acc, val) => val > acc ? val : acc, 0);

export function largestProduct(string, span) {

 if (span == 0) return 1;
  if (span <= 0) throw new Error('Span must be greater than zero');
  if (span > string.length) throw new Error('Span must be smaller than string length');
  if (string.match(/[^0-9]/)) throw new Error('Digits input must only contain digits');
  
  let digits = string.split('').map(d => Number.parseInt(d));
  let candidates = [];
  for (let i = 0; i < digits.length-span+1; i++) {
    candidates.push(digits.slice(i,i+span));
  }
  return max(candidates.map(a => product(a)));
};
