import gleam/regex
import gleam/string
import gleam/list

pub fn clean(input: String) -> Result(String, String) {
  let assert Ok(punctuations) = regex.from_string("[@:!]")
  let assert Ok(letters) = regex.from_string("[a-zA-Z]")
  
  case regex.check(punctuations, input), regex.check(letters, input) {
    True, _ -> Error("punctuations not permitted")
    _, True -> Error("letters not permitted")
    _, _ -> check_number(grep_digits(input))
  }
}

fn check_number(digits: List(String)) -> Result(String, String) {
  case list.length(digits) {
    l if l < 10 -> Error("must not be fewer than 10 digits")
    l if l > 11 -> Error("must not be greater than 11 digits")
    11 -> case nth(digits, 0) {
      "1" -> check_exchange_and_area_code(list.drop(digits, 1))
      _ -> Error("11 digits must start with 1")
    }
    10 -> check_exchange_and_area_code(digits)
    _ -> panic as "Unexpected pattern"
  }
}

fn check_exchange_and_area_code(ten_digit_number: List(String)) -> Result(String, String) {
  case nth(ten_digit_number, 0), nth(ten_digit_number, 3) {
    "0", _ -> Error("area code cannot start with zero")
    "1", _ -> Error("area code cannot start with one")
    _, "0" -> Error("exchange code cannot start with zero")
    _, "1" -> Error("exchange code cannot start with one")
    _, _ -> Ok(string.join(ten_digit_number, ""))
  }
}

fn nth(list: List(String), n: Int) -> String {
  let assert Ok(val) = list.first(list.drop(list, n))
  val
}

fn grep_digits(input) {
  let assert Ok(digits) = regex.from_string("[0-9]")
  regex.scan(digits, input)
  |> list.map(fn (m) {m.content})
}