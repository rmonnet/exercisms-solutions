import gleam/dict.{type Dict}
import gleam/regex
import gleam/list
import gleam/string
import gleam/option.{None, Some}

pub fn count_words(input: String) -> Dict(String, Int) {
  let assert Ok(re) = regex.from_string("[^a-zA-Z0-9']")
  input
  |> string.lowercase
  |> cleanup
  |> regex.split(re, _)
  |> list.map(cleanup)
  |> list.fold(dict.new(), incr_count)
  |> dict.delete("")
}

fn incr_count(dict, word) {
  dict.upsert(dict, word, fn(value) {
    case value {
      None -> 1
      Some(n) -> n + 1
    }
  })
}

fn cleanup(word) {
  case string.starts_with(word, "'") && string.ends_with(word, "'") {
    True -> word |> string.drop_left(1) |> string.drop_right(1)
    False -> word
  }
  
}