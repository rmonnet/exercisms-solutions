import gleam/string
import gleam/list
import gleam/set
import gleam/order.{Gt}

fn is_letter(l) {
  string.compare("a", l) != Gt && string.compare(l, "z") != Gt
}

pub fn is_isogram(phrase phrase: String) -> Bool {
  
  let #(_, result) = phrase
    |> string.lowercase
    |> string.to_graphemes
    |> list.fold(#(set.new(), True), fn(state, char) {
      let #(letters, is_isogram) = state
      case is_isogram && is_letter(char) {
        True ->
          case set.contains(letters, char) {
            True -> #(letters, False)
            False -> #(set.insert(letters, char), True)
          }
        False -> #(letters, is_isogram)
      }
    })
    result
}
