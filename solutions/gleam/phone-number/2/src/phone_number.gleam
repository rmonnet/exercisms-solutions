import gleam/regex
import gleam/string
import gleam/list
import gleam/result

pub fn clean(input: String) -> Result(String, String) {
  input
  |> remove_separators
  |> check_for_illegal_characters
  |> result.try(check_country_code_and_length)
  |> result.try(check_area_code)
  |> result.try(check_exchange_code)
}

fn remove_separators(input: String) -> String {
  let assert Ok(re) = regex.from_string("[+()-. ]")
  regex.replace(re, input, "")
}

fn check_for_illegal_characters(input: String) -> Result(String, String) {
  let assert Ok(punctuations) = regex.from_string("[@:!]")
  let assert Ok(letters) = regex.from_string("[a-zA-Z]")
  
  case regex.check(punctuations, input), regex.check(letters, input) {
    True, _ -> Error("punctuations not permitted")
    _, True -> Error("letters not permitted")
    _, _ -> Ok(input)
  }
}

fn check_country_code_and_length(input: String) -> Result(String, String) {
  case string.length(input) {
    l if l < 10 -> Error("must not be fewer than 10 digits")
    l if l > 11 -> Error("must not be greater than 11 digits")
    11 -> case string.first(input) {
      Ok("1") -> Ok(string.drop_left(input, 1))
      _ -> Error("11 digits must start with 1")
    }
    _-> Ok(input)
  }
}

fn check_area_code(input: String) -> Result(String, String) {
  case string.first(input) {
    Ok("0") -> Error("area code cannot start with zero")
    Ok("1") -> Error("area code cannot start with one")
    _ -> Ok(input)
  }
}


fn check_exchange_code(input: String) -> Result(String, String) {
  case string.first(string.drop_left(input,3)) {
    Ok("0") -> Error("exchange code cannot start with zero")
    Ok("1") -> Error("exchange code cannot start with one")
    _ -> Ok(input)
  }
}
