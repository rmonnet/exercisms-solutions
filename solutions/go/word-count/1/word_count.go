package wordcount

import (
	"regexp"
    "strings"
)

// A word is composed of letters and digits and possibly an apostrophe.
// If there is an apostrophe, there must be at least one letter before
// and one letter after the apostrophe.
var wordRe = regexp.MustCompile(`[a-zA-Z0-9]+('[a-zA-Z0-9]+)?`)

type Frequency map[string]int

func WordCount(phrase string) Frequency {
    res := make(Frequency)
	for _, match := range wordRe.FindAllString(strings.ToLower(phrase), -1) {
        res[match] += 1
    }
    return res
}
