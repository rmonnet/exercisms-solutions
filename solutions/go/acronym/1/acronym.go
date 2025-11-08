// Package acronym provides a function to convert a name into its acronym.
package acronym

import (
    "regexp"
    "strings"
)

var wordRe = regexp.MustCompile(`_(\w)[\w']*_|(\w)[\w']*`)

// Abbreviate converts a name into its acronym.
func Abbreviate(s string) string {
    words := wordRe.FindAllStringSubmatch(s, -1)
    var acronym strings.Builder
    for _, word := range words {
        if len(word[1]) > 0 {
        	acronym.WriteString(strings.ToUpper(word[1]))
        } else {
            acronym.WriteString(strings.ToUpper(word[2]))
        }
    }
	return acronym.String()
}
