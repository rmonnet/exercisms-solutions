package hamming

import "errors"

func Distance(a, b string) (int, error) {
    aLetters := []rune(a)
    bLetters := []rune(b)
	if len(aLetters) != len(bLetters) {
        return 0, errors.New("DNA strands must have same length")
    }
    dist := 0
    for i := 0; i < len(aLetters); i++ {
        if aLetters[i] != bLetters[i] {
            dist++
        }
    }
    return dist, nil
}
