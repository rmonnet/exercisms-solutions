package armstrong_numbers

import m "core:math"

is_armstrong_number :: proc(n: u128) -> bool {

	sum := u128(0)
	num := n
	len := number_digits(n)
	for num := n; num > 0; num = num / 10 {
		digit := uint(num % 10)
		sum += u128(power(digit, len))
	}
	return sum == n
}

number_digits :: proc(n: u128) -> uint {

	n_digits := uint(0)
	for i := n; i > 0; i /= 10 {
		n_digits += 1
	}
	return n_digits
}

power :: proc(n, p: uint) -> u128 {

	acc := u128(n)
	result := u128(1)
	exp := p
	for exp > 0 {
		if exp & 1 == 1 {
			result *= acc
		}
		acc = acc * acc
		exp >>= 1
	}
	return result
}
