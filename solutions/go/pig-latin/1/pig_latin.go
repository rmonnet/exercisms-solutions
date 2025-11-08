package piglatin

import (
    "regexp"
    "fmt"
    "strings"
)

var rule1Re = regexp.MustCompile(`^([aeiou]|xr|yt)`)

var rule2Re = regexp.MustCompile(`^([^aeiou]+)(.*)$`)

var rule3Re = regexp.MustCompile(`^([^aeiou]*qu)(.*)$`)

var rule4Re = regexp.MustCompile(`^([^aeiou]+)(y.*)$`)

func toPigLatin(word string) string {
	if rule1Re.MatchString(word) {
		return fmt.Sprintf("%say", word)
	}
	if parts := rule4Re.FindStringSubmatch(word); parts != nil {
		return fmt.Sprintf("%s%say", parts[2], parts[1])
	}
	if parts := rule3Re.FindStringSubmatch(word); parts != nil {
		return fmt.Sprintf("%s%say", parts[2], parts[1])
	}
	if parts := rule2Re.FindStringSubmatch(word); parts != nil {
		return fmt.Sprintf("%s%say", parts[2], parts[1])
	}
	return word
}

func Sentence(sentence string) string {
    var res strings.Builder
    for i, word := range strings.Split(sentence, " ") {
        if i > 0 {
            res.WriteRune(' ')
        }
        res.WriteString(toPigLatin(word))
    }
	return res.String()
}
