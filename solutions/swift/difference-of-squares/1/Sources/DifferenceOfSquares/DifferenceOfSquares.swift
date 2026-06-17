class Squares {
  let n: Int

  var sumOfSquares: Int { n * (n + 1) * (2 * n + 1) / 6 }

  var squareOfSum: Int {
    let sum = n * (n + 1) / 2
    return sum * sum
  }

  var differenceOfSquares: Int { squareOfSum - sumOfSquares }

  init(_ n: Int) {
    self.n = n
  }

}
