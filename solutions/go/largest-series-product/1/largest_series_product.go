package lsproduct

import (
    "errors"
)

// Series convert a string of digits into a slice of digits.
//
// It returns an error if one of the characters is not a digit (0-9).
func series(digits string) ([]int64, error) {
    res := make([]int64, len([]rune(digits)))
    for i, digit := range digits {
        if digit < '0' || digit > '9' {
            return nil, errors.New("Invalid digit")
        }
        res[i] = int64(digit - '0')
    }
    return res, nil
}

func product(digits []int64) int64 {
    res := int64(1)
    for _, digit := range digits {
        res *= digit
    }
    return res
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}

func LargestSeriesProduct(digits string, span int) (int64, error) {
    if span <= 0 {
        return 0, errors.New("Span must be positive")
    }
    digitSeries, err := series(digits)
    if err != nil {
        return 0, err
    }
    if span > len(digitSeries) {
        return 0, errors.New("Span is longer the series")
    }
	largestProduct := int64(0)
    for i:= 0; i+span-1 < len(digitSeries); i++ {
        largestProduct = max(largestProduct, product(digitSeries[i:i+span]))
    }
    return largestProduct, nil
}
