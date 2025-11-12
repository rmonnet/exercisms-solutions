
export function isArmstrongNumber(number) {

  const digits = number.toString().split('').map(d => Number.parseInt(d));
  let powerSum;
  if (digits.length < 16) {
    const exp = digits.length;
    powerSum = digits.reduce((acc,val) => acc+val**exp, 0);
  } else {
    const exp = BigInt(digits.length);
    powerSum = digits.reduce((acc,val) => acc+BigInt(val)**exp, 0n);
  }
  return number == powerSum;
};
