package wordy

import (
    "regexp"
    "strings"
    "strconv"
)

// Since there are no operator priorities (everything is evaluated left to right),
// there is no need to implement a real parser, a regular expression will do.
var exprRe = regexp.MustCompile(
    `^What is ((-?\d+)( (plus|minus|multiplied by|divided by) (-?\d+))*)\?$`)

func Answer(question string) (int, bool) {
    factors := exprRe.FindStringSubmatch(question)
    if factors == nil {
        return 0, false
    }
    // Remove the " by", they are not useful and prevent splitting properly on spaces.
    terms := strings.Split(strings.ReplaceAll(factors[1], " by", ""), " ")
    // Because the regular expression above matches, we know that
    // there are an odd number of terms that the terms with even indexes are
    // numbers and the terms with odd indexes are plus|minus|multiplied|divided
    // so we don't need to do error handling for these.
    res, _ := strconv.Atoi(terms[0])
    for i := 1; i < len(terms); i += 2 {
        operand, _ := strconv.Atoi(terms[i+1])
        switch terms[i] {
            case "plus": res += operand
            case "minus": res -= operand
            case "multiplied": res *= operand
            case "divided": res /= operand
        }
    }
    return res, true
}
