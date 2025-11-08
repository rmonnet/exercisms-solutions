
// Computes the greatest common divisor of a and b.
function gcd(a, b) {
  if (a < b) return gcd(b, a)
  if (b == 0) return a
  return gcd(b, a % b)
}

export class Rational {
  
  constructor(num, denum) {
    // normalize the ratio num/denum first
    // if num is zero then use 1/0
    // if the rational is negative always associate the negative sign with the numerator
    // divide both numerator and denominator by the lowest common multiple to get the smallest
    // equivalent rational.
    if (num == 0) {
      this._num = 0
      this._denum = 1
    } else {
      const sign = (num * denum) >= 0 ? 1 : -1
      num = Math.abs(num)
      denum = Math.abs(denum)
      const factor = gcd(num, denum)
      this._num = sign * num / factor
      this._denum = denum / factor
    }
  }

  add(other) {
    const denum = this._denum * other._denum / gcd(this._denum, other._denum)
    const num = this._num * (denum / this._denum) + other._num * (denum / other._denum)
    return new Rational(num, denum)
  }

  sub(other) {
    const denum = this._denum * other._denum / gcd(this._denum, other._denum)
    const num = this._num * (denum / this._denum) - other._num * (denum / other._denum)
    return new Rational(num, denum)
  }

  mul(other) {
    return new Rational(this._num * other._num, this._denum * other._denum)
  }

  div(other) {
    return new Rational(this._num * other._denum, this._denum * other._num)
  }

  abs() {
    return new Rational(Math.abs(this._num), this._denum)
  }

  exprational(exponent) {
    return new Rational(this._num**exponent, this._denum**exponent)
  }

  expreal(real) {
    return Math.fround(real**(this._num / this._denum))
  }

  reduce() {
    return this
  }
}
