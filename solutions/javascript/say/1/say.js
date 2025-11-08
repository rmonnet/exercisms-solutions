
const NAMES = {0: 'zero', 1: 'one', 2: 'two', 3: 'three', 4: 'four', 5: 'five', 6: 'six',
              7: 'seven', 8: 'eight', 9: 'nine', 10: 'ten', 11: 'eleven', 12: 'twelve', 13: 'thirteen',
              14: 'fourteen', 15: 'fifteen', 16: 'sixteen', 17: 'seventeen', 18: 'eighteen', 19: 'nineteen',
              20: 'twenty', 30: 'thirty', 40: 'forty', 50: 'fifty', 60: 'sixty', 70: 'seventy', 80: 'eighty',
              90: 'ninety'}

export function say(n) {

  if (n < 0 || n > 999999999999) throw new Error('Number must be between 0 and 999,999,999,999.')
  
  if (n <= 20) return NAMES[n]

  if (n < 100) {
    const d = Math.trunc(n / 10) * 10
    const r = n - d
    return (r == 0) ? NAMES[d] : `${NAMES[d]}-${say(r)}`
  }
  
  if (n < 1000) {
    const d = Math.trunc(n / 100)
    const r = n - d * 100
    return (r == 0) ? `${NAMES[d]} hundred` : `${NAMES[d]} hundred ${say(r)}`
  }

  if (n < 1000000) {
    const d = Math.trunc(n / 1000)
    const r = n - d * 1000
    return (r == 0) ? `${say(d)} thousand` : `${say(d)} thousand ${say(r)}` 
  }

  if (n < 1000000000) {
    const d = Math.trunc(n / 1000000)
    const r = n - d * 1000000
    return (r == 0) ? `${say(d)} million` : `${say(d)} million ${say(r)}` 
  }

  const d = Math.trunc(n / 1000000000)
  const r = n - d * 1000000000
  return (r == 0) ? `${say(d)} billion` : `${say(d)} billion ${say(r)}` 
};
