package allyourbase

import (
    "errors"
    "math"
)

// FromBase converts the input digits from the inputBase to base 10.
// The function returns an error if the digits are not within range
// [0, inputBase).
func fromBase(inputBase int, inputDigits []int) (int, error) {
	exp := 1
    res := 0
    for i := len(inputDigits)-1; i >= 0; i-- {
        if inputDigits[i] < 0 || inputDigits[i] >= inputBase {
            return 0, errors.New("all digits must satisfy 0 <= d < input base")
        }
        res += inputDigits[i] * exp
        exp *= inputBase
    }
    return res, nil
}

// ToBase converts an input from base 10 to the outputBase.
func toBase(outputBase int, input int) []int {
    if input == 0 {
        return []int{0}
    }
    // Find the number of digits requires to encode the number in outputBase.
    nDigits := math.Ceil(math.Log(float64(input))/math.Log(float64(outputBase)))
    exp := int(math.Pow(float64(outputBase), nDigits))
    // If the leftmost digit is 0, drop it.
    if exp > input {
        exp /= outputBase
    }
    // Encode the number by computing the factors of the input by
    // decreasing powers of outputBase.
    res := []int{}
    for exp > 0 {
        digit := input / exp
        input -= digit * exp
        exp /= outputBase
        res = append(res, digit)
    }
    return res
}

// ConvertToBase converts a sequence of digits representing a number
// in inputBase to a sequence of digits in outputBase. It returns an error
// if the inputBase or ouputBase is less than 2 or if some of the input digits
// don't belong to the inputBase.
func ConvertToBase(inputBase int, inputDigits []int, outputBase int) ([]int, error) {
    if inputBase < 2 {
        return nil, errors.New("input base must be >= 2")
    }
    if outputBase < 2 {
        return nil, errors.New("output base must be >= 2")
    }
	inputBase10, err := fromBase(inputBase, inputDigits)
    if err != nil {
        return nil, err
    }
    return toBase(outputBase, inputBase10), nil
}
