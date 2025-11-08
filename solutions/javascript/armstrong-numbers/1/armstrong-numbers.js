
export function isArmstrongNumber(number) {

  const digits = number.toString().split('').map(d => Number.parseInt(d));
  const exponent = digits.length
  const powerSum = digits.map(d => d**exponent).reduce((acc,val) => acc+val, 0);
  
  return number == powerSum;
};
