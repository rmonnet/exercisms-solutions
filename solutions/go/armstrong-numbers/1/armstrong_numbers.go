package armstrong

import "math"

func IsNumber(n int) bool {
    numDigits := math.Ceil(math.Log10(float64(n)))
    sum := float64(n)
    for n > 0 {
        sum -=  math.Pow(float64(n % 10), numDigits)
        n /= 10
    }
    return sum == 0
}
