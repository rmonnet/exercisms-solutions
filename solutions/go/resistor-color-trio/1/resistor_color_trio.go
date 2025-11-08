package resistorcolortrio

import "strconv"

var values = map[string]int {
    "black": 0, "brown": 1, "red": 2, "orange": 3, "yellow": 4,
	"green": 5, "blue": 6, "violet": 7, "grey": 8, "white": 9}

const (
    kilo = 1000
    mega = kilo * kilo
    giga = kilo * mega
)

// Label describes the resistance value given the colors of a resistor.
// The label is a string with a resistance value with an unit appended
// (e.g. "33 ohms", "470 kiloohms").
func Label(colors []string) string {
    res := 10 * values[colors[0]] + values[colors[1]]
    for i := 0; i < values[colors[2]]; i++ {
        res *= 10
    }
    suffix := " ohms"
    switch {
    case res == 0:
        // No change needed. We had this case so res == 0 doesn't trigger any of
        // the cases below.
    case res % giga == 0:
        res /= giga
        suffix = " gigaohms"
    case res % mega == 0:
        res /= mega
        suffix = " megaohms"
    case res % kilo == 0:
        res /= kilo
        suffix = " kiloohms"
    }
    return strconv.Itoa(res) + suffix
}
