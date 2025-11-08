import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/string

// We will store built-in and function definitions as ForthFn.
type ForthFn =
  fn(Forth) -> Result(Forth, ForthError)

pub type Forth {
  Forth(
    stack: List(Int),
    words: Dict(String, ForthFn),
    compile: Bool, // Indicates the interpreted is in compile mode (between ":" and ";").
    def: List(ForthFn), // Used to store the current definition in compile mode.
    def_name: String, // The name of the current definition in compile mode.
  )
}

pub type ForthError {
  DivisionByZero
  StackUnderflow
  InvalidWord
  UnknownWord
}

pub fn new() -> Forth {
  Forth(
    stack: [],
    compile: False,
    def: [],
    def_name: "",
    // We don't store ":" and ";" in the dictionary to ensure they can't be redefined.
    words: dict.from_list([
      #("+", do_op(_, fn(a, b) { a + b })),
      #("-", do_op(_, fn(a, b) { a - b })),
      #("*", do_op(_, fn(a, b) { a * b })),
      #("/", do_div),
      #("dup", do_dup),
      #("drop", do_drop),
      #("swap", do_swap),
      #("over", do_over),
    ]),
  )
}

pub fn format_stack(f: Forth) -> String {
  f.stack |> list.reverse |> list.map(int.to_string) |> string.join(" ")
}

pub fn eval(f: Forth, prog: String) -> Result(Forth, ForthError) {
  eval_next(Ok(f), string.split(prog, " ") |> list.map(string.lowercase))
}

// Evaluate the next word in the program.
fn eval_next(
  state: Result(Forth, ForthError),
  instr: List(String),
) -> Result(Forth, ForthError) {
  case state {
    Error(err) -> Error(err)
    Ok(f) ->
      case f.compile {
        True ->
          case instr {
            [":", ..] -> Error(InvalidWord)
            [";", ..rest] -> eval_next(do_semicolon(f), rest)
            [word, ..rest] -> eval_next(compile_word(f, word), rest)
            [] -> Error(InvalidWord)
          }
        False ->
          case instr {
            [] -> Ok(f)
            [":", name, ..rest] -> eval_next(do_colon(f, name), rest)
            [":"] -> Error(InvalidWord)
            [word, ..rest] ->
              case dict.get(f.words, word) {
                Ok(def) -> eval_next(def(f), rest)
                _ ->
                  case int.parse(word) {
                    Ok(n) ->
                      eval_next(Ok(Forth(..f, stack: [n, ..f.stack])), rest)
                    Error(_) -> Error(UnknownWord)
                  }
              }
          }
      }
  }
}

// Built-in function for "+", "-", and "*".
fn do_op(f: Forth, op) {
  case f.stack {
    [b, a, ..rest] -> Ok(Forth(..f, stack: [op(a, b), ..rest]))
    _ -> Error(StackUnderflow)
  }
}

// Built-in function for "/".
fn do_div(f: Forth) {
  case f.stack {
    [b, _, ..] if b == 0 -> Error(DivisionByZero)
    [b, a, ..rest] -> Ok(Forth(..f, stack: [a / b, ..rest]))
    _ -> Error(StackUnderflow)
  }
}

// Built-in function for "dup".
fn do_dup(f: Forth) {
  case f.stack {
    [a, ..rest] -> Ok(Forth(..f, stack: [a, a, ..rest]))
    _ -> Error(StackUnderflow)
  }
}

// Built-in function for "drop".
fn do_drop(f: Forth) {
  case f.stack {
    [_, ..rest] -> Ok(Forth(..f, stack: rest))
    _ -> Error(StackUnderflow)
  }
}

// Built-in function for "swap".
fn do_swap(f: Forth) {
  case f.stack {
    [b, a, ..rest] -> Ok(Forth(..f, stack: [a, b, ..rest]))
    _ -> Error(StackUnderflow)
  }
}

// Built-in function for "over".
fn do_over(f: Forth) {
  case f.stack {
    [b, a, ..rest] -> Ok(Forth(..f, stack: [a, b, a, ..rest]))
    _ -> Error(StackUnderflow)
  }
}

// Built-in function for ":".
fn do_colon(f: Forth, name: String) {
  case int.parse(name) {
    Ok(_) -> Error(InvalidWord)
    Error(_) if name == ":" -> Error(InvalidWord)
    Error(_) -> Ok(Forth(..f, compile: True, def_name: name))
  }
}

// Built-in function that execute a non-built word using the list of
// words in its definition.
// It used the definitions and not the word names so that we use the
// definition at the time of compilation, not the latest in the dictionary.
fn do_exec(f: Forth, funs: List(ForthFn)) -> Result(Forth, ForthError) {
  case funs {
    [] -> Ok(f)
    [fun, ..rest] ->
      case fun(f) {
        Ok(new_f) -> do_exec(new_f, rest)
        Error(err) -> Error(err)
      }
  }
}

// Creates a function to push an integer on the stack.
// This is used when we encounter an integer during compilation.
fn make_constant(n: Int) -> ForthFn {
  fn(f: Forth) { Ok(Forth(..f, stack: [n, ..f.stack])) }
}

// Compile the next word in the definition by adding its function body
// to the current definition.
fn compile_word(f: Forth, word: String) {
  case dict.get(f.words, word) {
    Ok(def) -> Ok(Forth(..f, def: [def, ..f.def]))
    _ ->
      case int.parse(word) {
        Ok(n) -> Ok(Forth(..f, def: [make_constant(n), ..f.def]))
        _ -> Error(UnknownWord)
      }
  }
}

// Built-in function for ";".
fn do_semicolon(f: Forth) {
  Ok(
    Forth(
      ..f,
      words: dict.insert(f.words, f.def_name, fn(s) {
        do_exec(s, list.reverse(f.def))
      }),
      def: [],
      def_name: "",
      compile: False,
    ),
  )
}
