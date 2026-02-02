package two_fer

import "core:fmt"

two_fer :: proc(name:= "you") -> string {
	return fmt.tprintf("One for %s, one for me.", name)
}
