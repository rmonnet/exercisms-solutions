import gleam/list
import gleam/order
import gleam/set
import gleam/string

fn pangram_letters() {
  "abcdefghijklmnopqrstuvwxyz"
  |> string.to_graphemes
  |> set.from_list
}

fn is_letter(c: String) -> Bool {
  string.compare("a", c) != order.Gt && string.compare(c, "z") != order.Gt
}

pub fn is_pangram(sentence: String) -> Bool {
  let letters =
    sentence
    |> string.lowercase
    |> string.to_graphemes
    |> list.filter(is_letter)
    |> set.from_list
  pangram_letters() == letters
}
