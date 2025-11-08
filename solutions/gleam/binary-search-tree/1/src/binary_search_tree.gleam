import gleam/list

pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

pub fn to_tree(data: List(Int)) -> Tree {
  list.fold(data, Nil, fn(tree, value) { insert(value, tree)})
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  data |> to_tree |> traverse
}

fn insert(value: Int, into: Tree) -> Tree {
  case into {
    Nil -> Node(value, Nil, Nil)
    Node(data, left, right) -> case value <= data {
      True -> Node(data, insert(value, left), right)
      False -> Node(data, left, insert(value, right))
    }
  }
}

fn traverse(tree: Tree) -> List(Int) {
  case tree {
    Nil -> []
    Node(data, left, right) -> list.append(traverse(left), [data, ..traverse(right)])
  }
}