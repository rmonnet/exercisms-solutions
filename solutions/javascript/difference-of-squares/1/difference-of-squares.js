
// Using formulaes described at https://helloacm.com/the-difference-between-sum-of-squares-and-square-of-the-sum

export class Squares {
  constructor(n) {
    this._limit = n;
  }

  get sumOfSquares() {
    const n = this._limit;
    return (n * (n + 1) * ((n * 2) + 1)) / 6;
    

  }

  get squareOfSum() {
    const n = this._limit;
    return Math.pow((n * (n + 1)) / 2, 2);
  }

  get difference() {
    return this.squareOfSum - this.sumOfSquares;
  }
}
