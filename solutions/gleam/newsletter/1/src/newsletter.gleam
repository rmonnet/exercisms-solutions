import simplifile
import gleam/result
import gleam/string
import gleam/list

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  case simplifile.read(path) {
    Ok(content) -> Ok(content |> string.trim_right |> string.split("\n"))
    Error(_) -> Error(Nil)
  }
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  simplifile.create_file(path)
  |> result.map_error(set_to_nil)
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  let content = simplifile.read(path) |> result.unwrap("")
  simplifile.write(path, content <> email <> "\n")
  |> result.map_error(set_to_nil)
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  create_log_file(log_path)
  |> result.try(fn(_) {
    read_emails(emails_path)
    |> result.map( fn(emails) {
      list.each(emails, fn(email) {
        send_email(email) |> result.try( fn(_) { log_sent_email(log_path, email)})
      })
    })
  })
}

fn set_to_nil(_) -> Nil {
  Nil
}