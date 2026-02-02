package custom_set

import "core:fmt"
import "core:slice"

Set :: map[int]bool

new_set :: proc(elements: ..int) -> Set {
	set: Set
	for element in elements {
		set[element] = true
	}
	return set
}

destroy_set :: proc(s: ^Set) {
	delete(s^)
}

to_string :: proc(s: Set) -> string {
	list := make([]int, len(s))
	defer delete(list)
	idx := 0
	for k, _ in s {
		list[idx] = k
		idx += 1
	}
	slice.sort(list)
	return fmt.aprintf("%v", list)
}

is_empty :: proc(s: Set) -> bool {
	return len(s) == 0
}

contains :: proc(s: Set, element: int) -> bool {
	return s[element]
}

is_subset :: proc(s: Set, other: Set) -> bool {
	for element in s {
		if !contains(other, element) { return false }
	}
	return true
}

is_disjoint :: proc(s: Set, other: Set) -> bool {
	for element in s {
		if contains(other, element) { return false }
	}
	for element in other {
		if contains(s, element) { return false }
	}
	return true
}

equal :: proc(s: Set, other: Set) -> bool {
	return is_subset(s, other) && is_subset(other, s)
}

add :: proc(s: ^Set, elements: ..int) {
	for element in elements {
		s[element] = true
	}
}

intersection :: proc(s: Set, other: Set) -> Set {
	inter: Set
	for element in s {
		if contains(other, element) {
			add(&inter, element)
		}
	}
	return inter
}

difference :: proc(s: Set, other: Set) -> Set {
	diff: Set
	for element in s {
		if !contains(other, element) {
			add(&diff, element)
		}
	}
	return diff
}

// union is a reserved word in Odin, using join instead.
join :: proc(s: Set, other: Set) -> Set {
	set: Set
	for element in s {
		set[element] = true
	}
	for element in other {
		set[element] = true
	}
	return set
}
