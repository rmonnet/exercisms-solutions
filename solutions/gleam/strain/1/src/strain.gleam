import gleam/list

pub fn keep(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  do_keep(list, predicate, [])
}

pub fn discard(list: List(t), predicate: fn(t) -> Bool) -> List(t) {
  do_keep(list, fn(e) {!predicate(e)}, [])
}

fn do_keep(list, pred, acc) {
  case list {
    [] -> list.reverse(acc)
    [first, ..rest] -> case pred(first) {
      True -> do_keep(rest, pred, [first, ..acc])
      False -> do_keep(rest, pred, acc)
    }
  }
}

