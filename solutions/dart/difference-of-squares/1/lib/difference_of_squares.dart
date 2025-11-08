class DifferenceOfSquares {
  int squareOfSum(int n) {
    int sum = n * (n + 1) ~/ 2;
    return sum * sum;
  }

  int sumOfSquares(int n) {
    return n * (n + 1) * (2 * n + 1) ~/ 6;
  }

  int differenceOfSquares(int n) {
    return squareOfSum(n) - sumOfSquares(n);
  }
}
