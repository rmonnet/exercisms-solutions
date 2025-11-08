import gleam/dict
import gleam/list

pub opaque type Set(t) {
  Set(dict: dict.Dict(t, Bool))
}

pub fn new(members: List(t)) -> Set(t) {
  members
  |> list.fold(dict.new(), fn(d, v) {dict.insert(d, v, True)})
  |> Set
}

pub fn is_empty(set: Set(t)) -> Bool {
  dict.is_empty(set.dict)
}

pub fn contains(in set: Set(t), this member: t) -> Bool {
  dict.has_key(set.dict, member)
}

pub fn is_subset(first: Set(t), of second: Set(t)) -> Bool {
  list.all(dict.keys(first.dict), fn(key) { dict.has_key(second.dict, key)})
}

pub fn disjoint(first: Set(t), second: Set(t)) -> Bool {
  list.all(dict.keys(first.dict), fn(key) { !dict.has_key(second.dict, key)})
}

pub fn is_equal(first: Set(t), to second: Set(t)) -> Bool {
  first.dict == second.dict
}

pub fn add(to set: Set(t), this member: t) -> Set(t) {
  Set(dict.insert(set.dict, member, True))
}

pub fn intersection(of first: Set(t), and second: Set(t)) -> Set(t) {
  Set(dict.take(first.dict, dict.keys(second.dict)))
}

pub fn difference(between first: Set(t), and second: Set(t)) -> Set(t) {
  Set(dict.drop(first.dict, dict.keys(second.dict)))
}

pub fn union(of first: Set(t), and second: Set(t)) -> Set(t) {
  Set(dict.merge(first.dict, second.dict))
}
