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
    return len(letters) == 26
}
