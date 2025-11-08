import gleam/string

pub fn message(log_line: String) -> String {
  let message = case log_line {
    "[INFO]: " <> msg -> msg
    "[ERROR]: " <> msg -> msg
    "[WARNING]: " <> msg -> msg
    _ -> log_line
  }
  string.trim(message)
}

pub fn log_level(log_line: String) -> String {
  case log_line {
    "[INFO]: " <> _ -> "info"
    "[ERROR]: " <> _ -> "error"
    "[WARNING]: " <> _ -> "warning"
    _ -> ""
  }
}

pub fn reformat(log_line: String) -> String {
  let level = case log_level(log_line) {
    "" -> ""
    l -> "(" <> l <> ")"
  }
  message(log_line) <> " " <> level
}
