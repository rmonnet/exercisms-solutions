package collatzconjecture

import "errors"

func next(n int) int {
    if n % 2 == 0 {
        return n / 2
    } else {
        return 3 * n + 1
    }
}
func CollatzConjecture(n int) (int, error) {
	if n <= 0 {
        return 0, errors.New("n must be positive.")
    }
    steps := 0
    for ; n != 1; n = next(n) {
        steps++
    }
    return steps, nil
}
