
export function isArmstrongNumber(number) {

  const digits = number.toString().split('').map(d => Number.parseInt(d));
  const powerSum = digits.reduce((acc,val) => acc+val**digits.length, 0);
  
  return number == powerSum;
};
