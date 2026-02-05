package line_up

import "core:fmt"

format :: proc(name: string, number: int) -> string {
	
	return fmt.aprintf(
        "%s, you are the %d%s customer we serve today. Thank you!",
        name, number, suffix(number))
}

suffix :: proc(n: int) -> string {

    switch {
    case (n % 10) == 1 && (n % 100) != 11: return "st"
    case (n % 10) == 2 && (n % 100) != 12: return "nd"
    case (n % 10) == 3 && (n % 100) != 13: return "rd"
    case: return "th"
    }
}