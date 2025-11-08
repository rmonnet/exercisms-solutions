import gleam/list
import gleam/set

pub type Tree(a) {
  Nil
  Node(value: a, left: Tree(a), right: Tree(a))
}

pub type Error {
  DifferentLengths
  DifferentItems
  NonUniqueItems
}

pub fn tree_from_traversals(
  inorder inorder: List(a),
  preorder preorder: List(a),
) -> Result(Tree(a), Error) {
  case list.length(inorder) == list.length(preorder) {
    False -> Error(DifferentLengths)
    True -> {
      let inset = set.from_list(inorder)
      let preset = set.from_list(preorder)
      case inset == preset {
        False -> Error(DifferentItems)
        True -> case list.length(inorder) == set.size(inset)
                      && list.length(preorder) == set.size(preset) {
            False -> Error(NonUniqueItems)
            True -> Ok(rebuild_tree(inorder, preorder))
        }
      }
    }
  }
}

fn rebuild_tree(
  inorder inorder: List(a),
  preorder preorder: List(a),
) -> Tree(a) {
  // We know that the inorder and preorder lists have the same length
  // and contains the same sets of unique elements so there is no need
  // for extra checks.
  case preorder {
    [], -> Nil
    [root, ..pre_minus_root] -> {
      let #(inleft, root_plus_inright) = list.split_while(inorder, fn(e) { e != root})
      let assert [_, ..inright] = root_plus_inright
      let length_inleft = list.length(inleft)
      let preleft = list.take(pre_minus_root, length_inleft)
      let preright = list.drop(pre_minus_root, length_inleft)
      Node(value: root,
        left: rebuild_tree(inleft, preleft),         
        right: rebuild_tree(inright, preright))
    }
  }
}


