package romannumerals

import "errors"

var numerals = map[int]string{
    1: "I", 5: "V", 10: "X", 50: "L", 100: "C", 500: "D", 1000: "M"}

func repeat(number, times int) string {
    res := ""
    for i:= 0; i < times; i++ {
        res += numerals[number]
    }
    return res
}

func ToRomanNumeral(input int) (string, error) {
	if input < 1 || input >= 4000 {
        return "", errors.New("Roman number must be between 1 and 3999")
    }
    number := ""
    if input >= 1000 {
    	nreps := input / 1000
    	number = repeat(1000, nreps)
    	input -= nreps * 1000
    }
    if input >= 900 {
        number += numerals[100] + numerals[1000]
        input -= 900
    }
    if input >= 500 {
        nreps := (input - 500) / 100
        number += numerals[500] + repeat(100, nreps)
        input -= 500 + nreps * 100
    }
    if input >= 400 {
        number += numerals[100] + numerals[500]
        input -= 400
    }
    if input >= 100 {
        nreps := input / 100
        number += repeat(100, nreps)
        input -= nreps * 100
    }
    if input >= 90 {
        number += numerals[10] + numerals[100]
        input -= 90
    }
    if input >= 50 {
        nreps:= (input - 50) / 10
        number += numerals[50] + repeat(10, nreps)
        input -= 50 + nreps * 10
    }
    if input >= 40 {
        number += numerals[10] + numerals[50]
        input -= 40
    }
    if input >= 10 {
        nreps := input / 10
        number += repeat(10, nreps)
        input -= nreps * 10
    }
    if input >= 9 {
        number += numerals[1] + numerals[10]
        input -= 9
    }
    if input >= 5 {
        nreps:= (input - 5)
        number += numerals[5] + repeat(1, nreps)
        input -= 5 + nreps
    }
    if input >= 4 {
        number += numerals[1] + numerals[5]
        input -= 4
    }
    if input >= 1 {
        nreps := input / 1
        number += repeat(1, nreps)
        input -= nreps
    }
    return number, nil
}
