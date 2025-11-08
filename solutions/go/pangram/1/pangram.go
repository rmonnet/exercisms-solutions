package pangram

import "strings"

func IsPangram(input string) bool {
    // Compute the frequency of each letter in the input string.
    frequency := [26]int{}
	for _, letter := range strings.ToUpper(input) {
        letterIndex := letter - 'A'
        // Skip non numerical characters.
        if letterIndex >= 0 && letterIndex < 26 {
            frequency[letterIndex] += 1
        }
    }
    // If any letter has a frequency of 0, then the input is not  pangram.
    prod := 1
    for _, count := range frequency {
        prod *= count
    }
    return prod != 0
}
