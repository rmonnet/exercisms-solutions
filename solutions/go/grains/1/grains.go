package grains

import "errors"

func Square(number int) (uint64, error) {
	if number < 1 || number > 64 {
        return 0, errors.New("square number must be between 1 and 64.")
    }
    res := uint64(1)
    for i := 2; i <= number; i++ {
        res *= 2
    }
    return res, nil
}

func Total() uint64 {
	sum := uint64(0)
    for i := 1; i <= 64; i++ {
        // We don't have to worry about the error returned by Square()
        // Since we only loop on valid square numbers.
        squareCount, _ := Square(i)
        sum += squareCount
    }
    return sum
}
