package isogram

import "core:strings"

is_isogram :: proc(word: string) -> bool {

    seen_before : bit_set['a'..='z']
    lc_word := strings.to_lower(word)
    defer delete(lc_word)
    for letter in lc_word {
        if letter < 'a' || letter > 'z' { continue }
        if letter in seen_before { return false}
        seen_before += {letter}
    }
	return true
}
