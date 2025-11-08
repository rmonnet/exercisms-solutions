import gleam/string
import gleam/result
import gleam/list


pub fn first_letter(name: String) {
  name |> string.trim_left() |> string.first() |> result.unwrap("X.")
}

pub fn initial(name: String) {
  {name |> first_letter() |> string.uppercase()} <> "."
}

pub fn initials(full_name: String) {
  full_name |> string.split(" ") |> list.map(initial) |> string.join(" ")
}

pub fn pair(full_name1: String, full_name2: String) {
  let initials1 = initials(full_name1)
  let initials2 = initials(full_name2)
"
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     " <> initials1 <> "  +  " <> initials2 <> "     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
}
