package flatten_array

Item :: union {
	i32,
	[]Item,
}

flatten :: proc(input: Item) -> []i32 {
	flat_array: [dynamic]i32
	flatten_rec(input, &flat_array)
	return flat_array[:]
}

flatten_rec :: proc(input: Item, acc: ^[dynamic]i32) {
	switch element in input {
	case i32:
		append(acc, element)
	case []Item:
		for subelement in element {
			flatten_rec(subelement, acc)
		}
	}
}
