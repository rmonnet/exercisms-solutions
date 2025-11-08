package transpose

// We assume that the text is ASCII (i.e. each rune is one byte).
import (
    "strings"
)

func Transpose(input []string) []string {
    if len(input) == 0 {
        return []string{}
    }
    // find the longest line
    ncols := len(input[0])
    for _, line := range input {
        if len(line) > ncols {
            ncols = len(line)
        }
    }
    nrows := len(input)
    // Invert rows and columns in the output
	res := make([]string, ncols)
    for r := 0; r < ncols; r++ {
        // Implicitely uses ASCII NUL as padding (can't use space since it is 
        // a valid input character).
        row := make([]byte, nrows)
        for c := 0; c < nrows; c++ {
            if r < len(input[c]) {
                row[c] = input[c][r]
            }
        }
        // Remove padding on the right (i.e. don't pad on right).
        // Then replace NUL padding with space padding.
        res[r] = strings.Replace(strings.TrimRight(string(row), "\x00"),
                                 "\x00", " ", -1)
    }
    return res
}
