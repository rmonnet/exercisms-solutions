import gleam/int
import gleam/string

pub type Clock {
  Clock(hour : Int, minute: Int)
}

pub fn create(hour hour: Int, minute minute: Int) -> Clock {

  case hour < 0, minute < 0, minute >= 60 {
    False, False, False, -> Clock(hour%24, minute)
    True, _, _ -> create(hour+24, minute)
    False, True, _ -> create(hour-1, minute+60)
    False, False, True -> create(hour+1, minute-60)
  }
}

pub fn add(clock: Clock, minutes minutes: Int) -> Clock {
  create(clock.hour, clock.minute + minutes)
}

pub fn subtract(clock: Clock, minutes minutes: Int) -> Clock {
  create(clock.hour, clock.minute - minutes)
}

pub fn display(clock: Clock) -> String {
  int_to_string(clock.hour) <> ":" <> int_to_string(clock.minute)
}

// Convert a number 'n' to a string of two characters
// left-padded with "0".
fn int_to_string(n: Int) -> String {
  n |> int.to_string |> string.pad_start(2, "0")
}