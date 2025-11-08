package raindrops

import "strconv"

func Convert(number int) string {
    out := ""
	if number % 3 == 0{
        out = "Pling"
    }
    if number % 5 == 0 {
        out += "Plang"
    }
	if number % 7 == 0 {
        out += "Plong"
    }
    if out == "" {
        out = strconv.Itoa(number)
    }
    return out
}
