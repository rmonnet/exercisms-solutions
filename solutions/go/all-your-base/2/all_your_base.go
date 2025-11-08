package allyourbase

import (
    "errors"
    "slices"
)

// FromBase converts the input digits from the inputBase to base 10.
// The function returns an error if the digits are not within range
// [0, inputBase).
func fromBase(inputBase int, inputDigits []int) (int, error) {
    if inputBase < 2 {
        return 0, errors.New("input base must be >= 2")
    }
    res := 0
    for _, digit := range inputDigits {
        if digit < 0 || digit >= inputBase {
            return 0, errors.New("all digits must satisfy 0 <= d < input base")
        }
        res = inputBase * res + digit
    }
    return res, nil
}

// ToBase converts an input from base 10 to the outputBase.
func toBase(outputBase int, input int) ([]int, error) {
    if outputBase < 2 {
        return nil, errors.New("output base must be >= 2")
    }
    if input == 0 {
        return []int{0}, nil
    }
    res := []int{}
    for input > 0 {
        digit := input % outputBase
        input /= outputBase
        res = append(res, digit)
    }
    slices.Reverse(res)
    return res, nil
}

// ConvertToBase converts a sequence of digits representing a number
// in inputBase to a sequence of digits in outputBase. It returns an error
// if the inputBase or ouputBase is less than 2 or if some of the input digits
// don't belong to the inputBase.
func ConvertToBase(inputBase int, inputDigits []int, outputBase int) ([]int, error) {
	inputBase10, err := fromBase(inputBase, inputDigits)
    if err != nil {
        return nil, err
    }
    return toBase(outputBase, inputBase10)
    
}
