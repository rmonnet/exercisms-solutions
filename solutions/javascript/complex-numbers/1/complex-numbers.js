
export class ComplexNumber {
  
  constructor(real, imag) {
    this._real = real;
    this._imag = imag;
  }

  get real() {
    return this._real;
  }

  get imag() {
    return this._imag;
  }

  add(other) {
    return new ComplexNumber(this.real + other.real, this.imag + other.imag);
  }

  sub(other) {
    return new ComplexNumber(this.real - other.real, this.imag - other.imag);
  }

  div(other) {
    const denum = (other.real * other.real + other.imag * other.imag);
    const real = (this.real * other.real + this.imag * other.imag) / denum;
    const imag = (this.imag * other.real - this.real * other.imag) / denum;
    return new ComplexNumber(real, imag);
  }

  mul(other) {
    const real = this.real * other.real - this.imag * other.imag;
    const imag = this.real * other.imag + this.imag * other.real;
    return new ComplexNumber(real, imag);
  }

  get abs() {
    return Math.sqrt(this.real * this.real + this.imag * this.imag);
  }

  get conj() {
    // javascript supports 0 and -0, we always want 0 here
    const imag = this.imag == 0 ? 0 : -this.imag;
    return new ComplexNumber(this.real, imag);
  }

  get exp() {
    const expReal = Math.exp(this.real);
    return new ComplexNumber(expReal * Math.cos(this.imag), expReal * Math.sin(this.imag));
  }
}
