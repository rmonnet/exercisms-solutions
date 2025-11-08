package isogram

import "strings"

func IsIsogram(word string) bool {
	found := make(map[rune]bool)
    for _, rune := range strings.ToLower(word) {
        // only check alphabetical letters
        if rune < 'a' || rune > 'z' {
            continue
        }
        if found[rune] {
            return false
        }
        found[rune] = true
    }
    return true
}
