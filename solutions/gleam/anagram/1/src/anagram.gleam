import gleam/string
import gleam/int
import gleam/list
import gleam/dict.{type Dict}
import gleam/option.{type Option, None, Some}

// Increments the count by 1.
fn inc(o: Option(Int)) -> Int {
  case o {
      None -> 1
      Some(n) -> n+1
  }
}

// Computes the frequency of each letter in a word.
fn freq(name: String) -> Dict(Int, Int) {
  name
    |> string.lowercase
    |> string.to_utf_codepoints()
    |> list.map(string.utf_codepoint_to_int)
    |> list.sort(by: int.compare)
    |> list.fold(dict.new(), fn(d, c) {dict.upsert(d, c, inc)})
}


pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  let word_freq = freq(word)
  let word_lc = string.lowercase(word)
  let is_anagram = fn(name) {
     freq(name) == word_freq && string.lowercase(name) != word_lc
  }
  list.filter(candidates, is_anagram)
}
