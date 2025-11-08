package prime

import "errors"

func isPrime(n int, primes []int) bool {
    for _, prime := range primes {
        if n % prime == 0 {
            return false
        }
    }
    return true
}

// Nth returns the nth prime number. An error must be returned if the nth prime number can't be calculated ('n' is equal or less than zero)
func Nth(n int) (int, error) {
	if n <= 0 {
        return 0, errors.New("n must be greater than zero")
    }
    primes := []int{2}
    for next := 3; len(primes) < n; next += 2 {
        if isPrime(next, primes) {
            primes = append(primes, next)
        }
    }
    return primes[len(primes)-1], nil
}
