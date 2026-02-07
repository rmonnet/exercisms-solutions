import gleam/string

pub fn reverse(value: String) -> String {
  reverse_rec(value, "")
}

fn reverse_rec(rest: String, acc: String) -> String {
  case rest {
    "" -> acc
    _ -> {
      let assert Ok(first) = string.first(rest)
      let new_rest = string.drop_start(rest, 1)
      reverse_rec(new_rest, first <> acc)
    }
  }
}