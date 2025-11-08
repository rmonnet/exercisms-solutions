package atbash

import "strings"

func encode(r rune) (rune, bool) {
    switch {
        case r >= '0' && r <= '9': return r, true
        case r >= 'a' && r <= 'z': return ('a' + 'z' - r), true
        case r >= 'A' && r <= 'Z': return ('a' + 'Z' - r), true
        default: return 0, false
    }
}

func Atbash(s string) string {
	var codedText strings.Builder
    count := 0
    for _, letter := range s {
        codedLetter, ok := encode(letter)
        if ok {
            // Insert a space after each group of five letters
            if count != 0 && count % 5 == 0 {
            	codedText.WriteRune(' ')
        	}
            codedText.WriteRune(codedLetter)
            count++
        }
    }
    return codedText.String()
}
