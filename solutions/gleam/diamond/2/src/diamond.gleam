import gleam/string
import gleam/list

pub fn build(letter: String) -> String {
  let rank = letter_to_int(letter) - letter_to_int("A")
  let ranks = case rank {
    0 -> [0]
    _ -> list.range(0, rank) |> list.append(list.range(rank-1, 0))
  }
  let length = 2 * rank + 1
  list.fold(ranks, [], fn(acc, rank) { [line(rank, length), ..acc]}) 
  |> string.join("\n")
}

fn letter_to_int(letter: String) -> Int {
  let assert [codepoint, ..] = string.to_utf_codepoints(letter)
  string.utf_codepoint_to_int(codepoint)
}

fn int_to_letter(value: Int) -> String {
   let assert Ok(codepoint) = string.utf_codepoint(value)
   string.from_utf_codepoints([codepoint])
}

fn line(rank: Int, length: Int) -> String {
  let outer_padding = string.repeat(" ", length / 2 - rank)
  let inner_line = case rank {
    0 -> "A"
    _ -> {
      let letter = int_to_letter(rank+letter_to_int("A"))
      let inner_padding = string.repeat(" ", 2 * rank - 1)
      letter<> inner_padding <> letter   
    }
  }
  outer_padding <> inner_line <> outer_padding
}