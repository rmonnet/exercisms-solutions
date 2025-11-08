package prime

import (
    "math"
)

func Factors(n int64) []int64 {

	factors := []int64{}

    // First remove all the '2' prime factors.
    for n % 2 == 0 {
        factors = append(factors, 2)
        n = n / 2
    }

    // Find all the prime factors under sqrt(n), where n is the left over
    // after removing all the '2' factors.
    // If i is not a prime, then it will have been removed from n when its
    // own factors are removed.
    limit := int64(math.Sqrt(float64(n))) + 1
    for i := int64(3); i < limit; i += 2 {
        for n % i == 0 {
            factors = append(factors, i)
            n = n / i
        }
    }

    // It is possible that there is one remaining factor.
    // Add it to the list.
    if n > 1 {
        factors = append(factors, n)
    }

    return factors
}
