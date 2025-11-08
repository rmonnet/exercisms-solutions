import gleam/list
import gleam/string

pub fn slices(input: String, size: Int) -> Result(List(String), Error) {
  case size, string.length(input) {
    s, _ if s < 0 -> Error(SliceLengthNegative)
    s, _ if s == 0 -> Error(SliceLengthZero)
    _, 0 -> Error(EmptySeries)
    s, l if l < s -> Error(SliceLengthTooLarge)
    _, _ -> Ok(get_slices(input, size, []))
  }
}

pub type Error {
  SliceLengthTooLarge
  SliceLengthZero
  SliceLengthNegative
  EmptySeries
}

fn get_slices(input: String, size: Int, acc: List(String)) -> List(String) {
  let length = string.length(input)
  case length < size {
    True -> list.reverse(acc)
    False -> get_slices(
      string.drop_left(input, 1),
      size,
      [string.drop_right(input, length-size), ..acc])
  }
}