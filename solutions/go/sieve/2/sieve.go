package sieve

// This second version attempts to conserve memory by only marking the odd numbers
// since 2 is the only even prime.
// The 'marked' array only represents odd numbers starting at 3:
// n=3 is at index 0, n=5 is at index 1 and so forth.
// The functions 'oddToIndex()' is used to convert between the two frames.


func oddToIndex(n int) int {
    return n / 2 - 1
}

func Sieve(limit int) []int {
    if limit < 2 {
        return []int{}
    }
    markedLength := limit / 2
	marked := make([]bool, markedLength)
    primes := []int{2}
    // Searching for primes through the odd numbers.
    for n:= 3; n <= limit; n += 2 {
        i := oddToIndex(n)
        if !marked[i] {
        	primes = append(primes, n)
        	for j:= 2*n; oddToIndex(j) < markedLength; j += n {
                // Only odd numbers are marked. We need to be careful since
                // oddToIndex(2*n) and oddToIndex(2n+1) return the same index.
                if j % 2 == 0 {
                    continue
                }
            	marked[oddToIndex(j)] = true
        	}
        }
    }
    return primes
}