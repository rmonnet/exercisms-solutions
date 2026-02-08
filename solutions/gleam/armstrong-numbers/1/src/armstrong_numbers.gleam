import gleam/list
import gleam/int

pub fn is_armstrong_number(number: Int) -> Bool {
  let digits = to_digits(number, [])
  let exp = list.length(digits)
  let sum = list.fold(digits, 0, fn(acc, x) { acc + pow(x, exp, 1)})
  sum == number
}

fn to_digits(n: Int, acc: List(Int)) -> List(Int) {
  case n {
    0 -> acc
    _ -> to_digits(n / 10, [n % 10, ..acc])
  }
}

fn pow(n: Int, times: Int, acc: Int) -> Int {
  case times {
    0 -> acc
    _ -> pow(n, times - 1, acc * n)
  }
}