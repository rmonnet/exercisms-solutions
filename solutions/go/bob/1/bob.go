// Package bob provides a function simulating greetings from Bob.
package bob

import "regexp"

var silence = regexp.MustCompile(`^\s*$`)
// Allow spaces after the question mark.
var yellQuestion = regexp.MustCompile(`^[^a-z]+\?\s*$`)
// Allow spaces after the question mark.
var yell = regexp.MustCompile(`^[^a-z]+$`)
var question = regexp.MustCompile(`\?\s*$`)
var noLetters = regexp.MustCompile(`^[^A-Z]+$`)


// Hey generates a greeting from Bob in response to a remark.
func Hey(remark string) string {
    if silence.MatchString(remark) {
        return "Fine. Be that way!"
    }
    if yellQuestion.MatchString(remark) && ! noLetters.MatchString(remark) {
        return "Calm down, I know what I'm doing!"
    }
    if yell.MatchString(remark) && ! noLetters.MatchString(remark) {
        return "Whoa, chill out!"
    }
    if question.MatchString(remark) {
        return "Sure."
    }
	return "Whatever."
}
