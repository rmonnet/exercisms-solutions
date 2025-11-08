package romannumerals

import (
    "errors"
    "strings"
)

var numerals = map[int]string{
    1: "I", 5: "V", 10: "X", 50: "L", 100: "C", 500: "D", 1000: "M"}

func convertUnit(input, unit int, output *strings.Builder) (remaining int) {

    addNumeral := func(number, times int) {
        for i:= 0; i < times; i++ {
        	output.WriteString(numerals[number])
    	}
    }

    remaining = input
        
    if remaining >= 9 * unit {
        addNumeral(unit, 1)
        addNumeral(10 * unit, 1)
        remaining -= 9 * unit
    }
    if remaining >= 5 * unit {
        nreps := (remaining - 5 * unit) / unit
        addNumeral(5 * unit, 1)
        addNumeral(unit, nreps)
        remaining -= 5 * unit + nreps * unit
    }
    if remaining >= 4 * unit {
        addNumeral(unit, 1)
        addNumeral(5 * unit, 1)
        remaining -= 4 * unit
    }
    if remaining >= unit {
        nreps := remaining / unit
        addNumeral(unit, nreps)
        remaining -= nreps * unit
    }
    return remaining
} 

func ToRomanNumeral(input int) (string, error) {
	if input < 1 || input >= 4000 {
        return "", errors.New("Roman number must be between 1 and 3999")
    }
    var output = &strings.Builder{}
    remaining := convertUnit(input, 1000, output)
    remaining = convertUnit(remaining, 100, output)
    remaining = convertUnit(remaining, 10, output)
    remaining = convertUnit(remaining, 1, output)

    return output.String(), nil
}
