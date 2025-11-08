package cryptosquare

import (
    "regexp"
    "strings"
    "math"
)

var punctuationRe = regexp.MustCompile(`[.,:!?#%^&$\s]`)

// Normalize removes punctuation and convert all letters to lower case.
func normalize(s string) []rune {
    return []rune(strings.ToLower(punctuationRe.ReplaceAllString(s, "")))
}

// Dimensions computes the dimension of the rectangle closest to a square.
// Rules: nrow*ncol >= n, ncol >= nrow, ncol - nrow <= 1.
func dimensions(n int) (nrow, ncol int) {
    // Find the integer floor of sqrt(n).
    nrow = int(math.Sqrt(float64(n)))
	// N is a perfect square.
    if nrow*nrow == n {
        ncol = nrow
    // Not a perfect square, increment ncol first.
    } else {
        ncol = nrow + 1
    }
    // Still not enough, increment nrow.
    if nrow*ncol < n {
        nrow += 1
    }
    return
}

// Encode converts the input to a crypto square.
func Encode(pt string) string {
    if pt == "" {
        return ""
    }
    letters := normalize(pt)
    nrow, ncol := dimensions(len(letters))
    codedText := make([]rune, (ncol*nrow)+ncol-1)
    i := 0
    // Note: row and col designate the plain text, they are reversed for
    // the encoded text.
    for c := 0; c < ncol; c++ {
        // Add a space at the end of each col (i.e. encoded row) but the first.
        if c > 0 {
            codedText[i] = ' '
            i++
        }
        for r:= 0; r < nrow; r++ {
            letterIndex := c+r*ncol
            if letterIndex < len(letters) {
                codedText[i] = letters[letterIndex]
            } else {
                // We have run out of plain text, add spaces.
                codedText[i] = ' '
            }
            i++
        }
    }
    return string(codedText)
}
