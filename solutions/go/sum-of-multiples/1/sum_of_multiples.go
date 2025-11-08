package summultiples

func SumMultiples(limit int, divisors ...int) int {

	uniques := map[int]bool{}
    for _, divisor := range divisors {
        if divisor == 0 {
            continue
        }
        for i := 1; i*divisor < limit; i++ {
            uniques[i*divisor] = true
        } 
    }
    sum := 0
    for unique, _ := range uniques {
        sum += unique
    }
    return sum
}
