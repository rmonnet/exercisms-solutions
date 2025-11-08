package say

import "fmt"

const (
	zero = "zero"
)

var unitaries = []string{zero, "one", "two", "three", "four", "five", "six", "seven",
	"eight", "nine", "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen",
	" sixteen", "seventeen", "eighteen", "nineteen"}

var tens = []string{"", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"}

var units = []struct {
	limit   int64
	divisor int64
	name    string
}{
	{1_000, 100, "hundred"}, {1_000_000, 1_000, "thousand"}, {1_000_000_000, 1_000_000, "million"},
	{1_000_000_000_000, 1_000_000_000, "billion"}}

func Say(n int64) (string, bool) {
	if n < 0 {
		return "", false

	}
	if n < 20 {
		return unitaries[n], true
	}
	if n < 100 {
		unitary := unitaries[n%10]
		ten := tens[n/10]
		if unitary == zero {
			return ten, true
		} else {
			return fmt.Sprintf("%s-%s", ten, unitary), true
		}
	}
	for _, unit := range units {
		if n >= unit.limit {
			continue
		}
		bottom, _ := Say(n % unit.divisor)
		top, _ := Say(n / unit.divisor)
		if bottom == zero {
			return fmt.Sprintf("%s %s", top, unit.name), true
		} else {
			return fmt.Sprintf("%s %s %s", top, unit.name, bottom), true
		}
	}
	return "", false
}
