import gleam/string
import gleam/regex

pub fn hey(remark: String) -> String {

  let trimmed_remark = string.trim(remark)

  let is_yelling = string.uppercase(trimmed_remark) == trimmed_remark &&
    string.lowercase(trimmed_remark) != trimmed_remark
   
  let is_question = string.ends_with(trimmed_remark, "?")

  let is_silence = trimmed_remark == ""

  case is_yelling, is_question, is_silence {
    _, _, True        -> "Fine. Be that way!"
    True, True, False -> "Calm down, I know what I'm doing!"
    _, True, _        -> "Sure."
    True, _, _        -> "Whoa, chill out!"
    _, _, _           -> "Whatever."
  }
}
