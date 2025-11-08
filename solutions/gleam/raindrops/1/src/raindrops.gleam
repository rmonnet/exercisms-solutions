import gleam/int

fn sound_for(number: Int, divisor: Int, sound: String) -> String {
  case number % divisor {
    0 -> sound
    _ -> ""
  }
}

pub fn convert(number: Int) -> String {
  let sound = sound_for(number, 3, "Pling") <>
    sound_for(number, 5, "Plang") <>
    sound_for(number, 7, "Plong")
  case sound {
    "" -> int.to_string(number)
    _ -> sound
  }
}
