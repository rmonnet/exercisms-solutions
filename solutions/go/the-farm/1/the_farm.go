package thefarm

import (
    "errors"
    "fmt"
)

// DivideFood computes the ration of food for each cow based on
// the given FodderCalculator and the number of cows.
func DivideFood(calc FodderCalculator, numberOfCows int) (float64, error) {
    amount, err := calc.FodderAmount(numberOfCows)
    if err != nil {
        return 0.0, err
    }
    factor, err := calc.FatteningFactor()
    return amount * factor /float64(numberOfCows), err
}

// ValidateInputAndDivideFood computes the ration of food for each cow based on the
// given FodderCalculator and the number of cows. If the number of cows is invalid,
// it will return an appropriate error.
func ValidateInputAndDivideFood(calc FodderCalculator, numberOfCows int) (float64, error) {
    if numberOfCows <= 0 {
        return 0.0, errors.New("invalid number of cows")
    }
    return DivideFood(calc, numberOfCows)
}

// InvalidCowsError represents specific errors associated with
// invalid number of cows. Specifically, *InvalidCowsError represents an error.
type InvalidCowsError struct {
    numberOfCows int
    message string
}

// Error returns the error message associated with an *InvalidCowError error.
func (e *InvalidCowsError) Error() string {
    return fmt.Sprintf("%d cows are invalid: %s", e.numberOfCows, e.message)
}
// ValidateNumberOfCows returns an error if the number of cows is invalid.
func ValidateNumberOfCows(numberOfCows int) error {
    if numberOfCows < 0 {
        return &InvalidCowsError{numberOfCows, "there are no negative cows"}
    }
    if numberOfCows == 0 {
        return &InvalidCowsError{0, "no cows don't need food"}
    }
    return nil
}
