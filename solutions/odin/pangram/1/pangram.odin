package pangram

import "core:strings"

is_pangram :: proc(str: string) -> bool {

    letters : map[rune]bool
    lc_str := strings.to_lower(str)
    defer delete(lc_str)
    for letter in lc_str {
        if letter < 'a' || letter > 'z' { continue }
        letters[letter] = true
    }
    for letter in 'a'..='z' {
        if letter not_in letters { return false}
    }
	return true
}
