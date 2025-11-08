import gleam/list

// Computes a row from the previous one. 
fn row_from_previous(previous_row, current, row) {
  case previous_row {
    [] -> list.reverse([1, ..row])
    [x, ..xs] -> row_from_previous(xs, x, [current+x, ..row])
  }
}

// Builds up to the nth row.
fn build_rows(n, previous, rows) {
  case n {
    0 -> list.reverse(rows)
    _ -> {
      let row = row_from_previous(previous, 0, [])
      build_rows(n-1, row, [row, ..rows])
    }
  }
}

pub fn rows(n: Int) -> List(List(Int)) {
  build_rows(n, [], [])
  
}
