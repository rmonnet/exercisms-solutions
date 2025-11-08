package palindrome

import (
	"errors"
	"math"
)

// Define Product type here.
type Product struct {
	Value          int
	Factorizations [][2]int
}

func Products(fmin, fmax int) (Product, Product, error) {
	if fmin > fmax {
		return Product{}, Product{}, errors.New("fmin > fmax")
	}
	minPalindrome := math.MaxInt
	maxPalindrome := 0
	for i := fmin; i <= fmax; i++ {
		for j := fmin; j <= fmax; j++ {
			candidate := i * j
			if isPalindrome(candidate) {
				if minPalindrome > candidate {
					minPalindrome = candidate
				}
				if maxPalindrome < candidate {
					maxPalindrome = candidate
				}
			}
		}
	}
	if maxPalindrome == 0 {
		return Product{}, Product{}, errors.New("no palindromes...")
	}
	return Product{minPalindrome, factorize(fmin, fmax, minPalindrome)},
		Product{maxPalindrome, factorize(fmin, fmax, maxPalindrome)},
		nil
}

func factorize(fmin, fmax, palindrome int) [][2]int {
	res := [][2]int{}
	for i := fmin; i <= fmax; i++ {
		factor := palindrome / i
		if (palindrome-i*factor) == 0 && fmin <= factor && factor <= fmax && i <= factor {
			res = append(res, [2]int{i, factor})
		}
	}
	return res
}

func isPalindrome(n int) bool {
	digits := toDigits(n)
	nDigits := len(digits)
	for i := 0; i < nDigits; i++ {
		if digits[i] != digits[nDigits-1-i] {
			return false
		}
	}
	return true
}

func toDigits(n int) []int {
	res := []int{}
	for n > 0 {
		res = append(res, n%10)
		n = n / 10
	}
	return res
}
