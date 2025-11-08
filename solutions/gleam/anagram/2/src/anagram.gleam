import gleam/string
import gleam/list


// reorder all the letters in the word in alphabetical order
// and convert to lowercase
fn letters(word: String) -> String {
  word
    |> string.lowercase
    |> string.to_graphemes
    |> list.sort(by: string.compare)
    |> string.concat
}


pub fn find_anagrams(word: String, candidates: List(String)) -> List(String) {
  let word_letters = letters(word)
  let word_lc = string.lowercase(word)
  let is_anagram = fn(name) {
     letters(name) == word_letters && string.lowercase(name) != word_lc
  }
  list.filter(candidates, is_anagram)
}
