func dartScore(x: Double, y: Double) -> Int {
  return switch (x * x + y * y).squareRoot() {
  case let d where d <= 1: 10
  case let d where d <= 5: 5
  case let d where d <= 10: 1
  default: 0
  }
}
