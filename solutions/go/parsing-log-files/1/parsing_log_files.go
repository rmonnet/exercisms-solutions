package parsinglogfiles

import (
    "regexp"
    "fmt"
)

// Define regexp in the package but outside the functions
// so they are only computed once.
var validLineRE = regexp.MustCompile(`^\[(TRC|DG|INF|WRN|ERR|FTL)\]`)
var lineSepRE = regexp.MustCompile(`<[~*=-]*>`)
var pwdRE = regexp.MustCompile(`(?i)"[^"]*password[^"]*"`)
var eolRE = regexp.MustCompile(`end-of-line\d+`)
var userRE = regexp.MustCompile(`User\s+(\w(\w|\d)+)`)

func IsValidLine(text string) bool {
	return validLineRE.MatchString(text)
}

func SplitLogLine(text string) []string {
	return lineSepRE.Split(text, -1)
}

func CountQuotedPasswords(lines []string) int {
	count := 0
    for _, line := range lines {
        count += len(pwdRE.FindAllString(line, 2))
    }
    return count
}

func RemoveEndOfLineText(text string) string {
	return eolRE.ReplaceAllString(text, "")
}

func TagWithUserName(lines []string) []string {
    var res []string
    for _, line := range lines {
        matches := userRE.FindStringSubmatch(line)
        if matches != nil {
            line = fmt.Sprintf("[USR] %s %s", matches[1], line)
        }
        res = append(res, line)
    }
	return res
}
