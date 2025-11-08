import gleam/list

type Domino =
  #(Int, Int)

fn connect(a: Domino, b: Domino) -> Domino {
  case a.1 == b.0 {
    True -> b
    False -> #(b.1, b.0)
  }
}

fn remove(list: List(Domino), value: Domino) -> List(Domino) {
  let first = list |> list.take_while(fn(e) { e != value })
  let second = list |> list.drop_while(fn(e) { e != value })
  case second {
    [] -> first
    [_, ..rest] -> list.append(first, rest)
  }
}

fn complete_chain(first: Domino, last: Domino, candidates: List(Domino)) -> Bool {
  case candidates {
    [candidate] if last.1 == candidate.0 && candidate.1 == first.0 -> True
    [candidate] if last.1 == candidate.1 && candidate.0 == first.0 -> True
    [_] -> False
    _ -> {
      candidates
      |> list.filter(fn(d) { last.1 == d.0 || last.1 == d.1 })
      |> list.map(fn(d) {
        complete_chain(first, connect(last, d), remove(candidates, d))
      })
      |> list.any(fn(a) { a == True })
    }
  }
}

pub fn can_chain(chain: List(Domino)) -> Bool {
  case chain {
    [] -> True
    [singleton] -> singleton.0 == singleton.1
    [first, ..rest] -> complete_chain(first, first, rest)
  }
}
