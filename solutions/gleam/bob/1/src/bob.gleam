import gleam/string
import gleam/regex

pub fn hey(remark: String) -> String {

  let trimmed_remark = remark
    |> string.replace("\n", "")
    |> string.replace("\r", "")
    |> string.trim()

  let is_yelling = yelling(trimmed_remark)
   
  let is_question = string.ends_with(trimmed_remark, "?")

  case trimmed_remark {
    r if r == ""                   -> "Fine. Be that way!"
    _ if is_yelling && is_question -> "Calm down, I know what I'm doing!"
    _ if is_question               -> "Sure."
    _ if is_yelling                -> "Whoa, chill out!"
    _                              -> "Whatever."
  }
}

fn yelling(remark: String) -> Bool {
  // Remark needs to contain at least one letter and it needs to look the same
  // when converted to uppercase.
  let assert Ok(re) = regex.from_string("[A-Z]+")
  regex.check(with: re, content: remark) &&
    string.uppercase(remark) == remark
}