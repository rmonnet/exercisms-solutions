package perfect

import (
    "errors"
)

// Define the Classification type here.
type Classification int

const (
    ClassificationPerfect = iota
    ClassificationAbundant
    ClassificationDeficient
)

func aliquotSum(n int64) int64 {
    sum := int64(0)
    for i := int64(1); i < n; i++ {
        if n % i == 0 {
            sum += i
        }
    }
    return sum
}
var ErrOnlyPositive = errors.New("Number must be positive")

func Classify(n int64) (Classification, error) {
	if n <= 0 {
        return ClassificationPerfect, ErrOnlyPositive
    }
    sum := aliquotSum(n)
    switch {
    case sum > n: return ClassificationAbundant, nil
    case sum < n: return ClassificationDeficient, nil
    default: return ClassificationPerfect, nil
    }
}
