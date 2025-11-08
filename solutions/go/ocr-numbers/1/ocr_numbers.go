package ocr

import (
	"strings"
)

const (
	nRowsPerDigit = 4
	nColsPerDigit = 3
)

type segment [nRowsPerDigit]string

var digits = map[segment]string{
	{" _ ", "| |", "|_|", "   "}: "0", {"   ", "  |", "  |", "   "}: "1", {" _ ", " _|", "|_ ", "   "}: "2",
	{" _ ", " _|", " _|", "   "}: "3", {"   ", "|_|", "  |", "   "}: "4", {" _ ", "|_ ", " _|", "   "}: "5",
	{" _ ", "|_ ", "|_|", "   "}: "6", {" _ ", "  |", "  |", "   "}: "7", {" _ ", "|_|", "|_|", "   "}: "8",
	{" _ ", "|_|", " _|", "   "}: "9"}

func recognizeDigit(digitRep segment) string {
	value, ok := digits[digitRep]
	if !ok {
		return "?"
	}
	return value
}

func Recognize(input string) []string {
	// The first line is empty (input starts with "\n").
	lines := strings.Split(input, "\n")
	nNumbers := (len(lines) - 1) / nRowsPerDigit
	if (len(lines)-1)-nRowsPerDigit*nNumbers != 0 {
        // There is no way to report an error through this function.
		panic("Invalid input, number of lines is incorrect (must be a multiple of 4 +1)")
	}
	res := []string{}
	for n := 0; n < nNumbers; n++ {
		nDigits := len(lines[1+4*n]) / nColsPerDigit
		for i := 0; i < nRowsPerDigit; i++ {
			if len(lines[1+4*n+i])-nColsPerDigit*nDigits != 0 {
                // There is no way to report an error through this function.
				panic("invalid input, number of vertical segment is incorrect (must be a multiple of 3)")
			}
		}
		var digitRep segment
		acc := []string{}
		for d := 0; d < nDigits; d++ {
			for i := 0; i < nRowsPerDigit; i++ {
				digitRep[i] = lines[1+4*n+i][3*d : 3*(d+1)]
			}
			acc = append(acc, recognizeDigit(digitRep))
		}
		res = append(res, strings.Join(acc, ""))
	}
	return res
}
