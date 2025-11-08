import gleam/string


pub fn first_letter(name: String) {
  case name |> string.trim_left() |> string.first() {
    Ok(letter) -> letter
    Error(_) -> "X."
  }
}

pub fn initial(name: String) {
  {name |> first_letter() |> string.uppercase()} <> "."
}

pub fn initials(full_name: String) {
  case string.split(full_name, on: " ") {
    [firstname, lastname] -> initial(firstname) <> " " <> initial(lastname)
    _ -> "X. X."
  }
}

pub fn pair(full_name1: String, full_name2: String) {
  let initials1 = initials(full_name1)
  let initials2 = initials(full_name2)
"
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **"
<> "
**     " <> initials1 <> "  +  " <> initials2 <> "     **"
<> "
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
