import gleam/dict
import gleam/list

pub opaque type Set(t) {
  Set(values: dict.Dict(t, Bool))
}

pub fn new(members: List(t)) -> Set(t) {
  members
  |> list.fold(dict.new(), fn(d, v) {dict.insert(d, v, True)})
  |> Set
}

pub fn is_empty(set: Set(t)) -> Bool {
  let Set(dict) = set
  dict.is_empty(dict)
}

pub fn contains(in set: Set(t), this member: t) -> Bool {
  let Set(dict) = set
  dict.has_key(dict, member)
}

pub fn is_subset(first: Set(t), of second: Set(t)) -> Bool {
  let Set(first_dict) = first
  let Set(second_dict) = second
  list.all(dict.keys(first_dict), fn(key) { dict.has_key(second_dict, key)})
}

pub fn disjoint(first: Set(t), second: Set(t)) -> Bool {
  let Set(first_dict) = first
  let Set(second_dict) = second
  list.all(dict.keys(first_dict), fn(key) { !dict.has_key(second_dict, key)})
}

pub fn is_equal(first: Set(t), to second: Set(t)) -> Bool {
  let Set(first_dict) = first
  let Set(second_dict) = second
  first_dict == second_dict
}

pub fn add(to set: Set(t), this member: t) -> Set(t) {
  let Set(dict) = set
  Set(dict.insert(dict, member, True))
}

pub fn intersection(of first: Set(t), and second: Set(t)) -> Set(t) {
  let Set(first_dict) = first
  let Set(second_dict) = second
  dict.keys(first_dict)
  |> list.fold(dict.new(), fn(d, v) {
    case dict.has_key(second_dict, v) {
      True -> dict.insert(d, v, True)
      False -> d
    }
  })
  |> Set
}

pub fn difference(between first: Set(t), and second: Set(t)) -> Set(t) {
  let Set(first_dict) = first
  let Set(second_dict) = second
  dict.keys(first_dict)
  |> list.fold(dict.new(), fn(d, v) {
    case dict.has_key(second_dict, v) {
      False -> dict.insert(d, v, True)
      True -> d
    }
  })
  |> Set
}

pub fn union(of first: Set(t), and second: Set(t)) -> Set(t) {
  let Set(first_dict) = first
  let Set(second_dict) = second
  Set(dict.merge(first_dict, second_dict))
}
