package sieve

func Sieve(limit int) []int {
    if limit < 2 {
        return []int{}
    }
	marked := make([]bool, limit+1)
    primes := []int{}
    for i:= 2; i <= limit; i++ {
        if !marked[i] {
        	primes = append(primes, i)
        	for j:= 2; i*j <= limit; j++ {
            	marked[i*j] = true
        	}
        }
    }
    return primes
}
