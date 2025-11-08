package alphametics

import (
	"errors"
	"fmt"
	"slices"
	"strings"
)

func Solve(puzzle string) (map[string]int, error) {
	pb, err := parseProblem(puzzle)
	if err != nil {
		return nil, err
	}
	sol := &solution{code: map[byte]int{}}
	ok := try(pb, sol)
	if !ok {
		return nil, errors.New("no solution found")
	}
	res := map[string]int{}
	for letter, value := range sol.code {
		res[string(letter)] = value
	}
	return res, nil
}

type problem struct {
	value   string
	factors []string
	nonZero map[byte]bool
	letters []byte
}

func parseProblem(puzzle string) (problem, error) {
	var res problem
	terms := strings.Split(puzzle, " == ")
	if len(terms) != 2 {
		return problem{}, errors.New("puzzle not in the form 'expr == value'")
	}
	res.value = terms[1]
	if len(res.value) > 10 {
		return problem{}, errors.New("too many digits in value")
	}
	res.factors = strings.Split(terms[0], " + ")
	if len(res.factors) < 2 {
		return problem{}, errors.New("expression not in the form 'factor + factor ...'")
	}
	for _, factor := range res.factors {
		if len(factor) > len(res.value) {
			return problem{}, errors.New("too many digits in factor")
		}
	}
	res.letters = lettersInPuzzle(puzzle)
	res.nonZero = nonZeroLettersInPuzzle(res.factors, res.value)
	return res, nil
}

type solution struct {
	digitAssigned [10]bool
	code          map[byte]int
}

func try(pb problem, sol *solution) bool {
	if len(sol.code) == len(pb.letters) {
		return isPuzzleSolved(pb, sol)
	}
	letter := pb.letters[len(sol.code)]
	for d := 0; d < 10; d++ {
		if sol.digitAssigned[d] || (d == 0 && pb.nonZero[letter]) {
			continue
		}
		// Assign letter to digit.
		sol.code[letter] = d
		sol.digitAssigned[d] = true
		ok := try(pb, sol)
		if ok {
			return true
		}
		// Unassign letter to digit.
		delete(sol.code, letter)
		sol.digitAssigned[d] = false
	}
	// None of the try worked, no solution on this path.
	return false
}

func isPuzzleSolved(pb problem, sol *solution) bool {
	sum := 0
	for _, factor := range pb.factors {
		sum += decode(factor, sol.code)
	}
	value := decode(pb.value, sol.code)
	return sum == value
}

func lettersInPuzzle(puzzle string) []byte {
	// We are assuming all the letters in the puzzle are upper case ASCII [A-Z]
	used := map[byte]bool{}
	for i := 0; i < len(puzzle); i++ {
		if 'A' <= puzzle[i] && puzzle[i] <= 'Z' {
			used[puzzle[i]] = true
		}
	}
	res := make([]byte, 0, len(used))
	for letter := range used {
		res = append(res, letter)
	}
	slices.Sort(res)
	return res
}

func nonZeroLettersInPuzzle(factors []string, value string) map[byte]bool {
	// We are assuming all the letters in the puzzle are upper case ASCII [A-Z]
	nonZero := map[byte]bool{}
	if len(value) > 1 {
		nonZero[value[0]] = true
	}
	for _, factor := range factors {
		if len(factor) > 1 {
			nonZero[factor[0]] = true
		}
	}
	return nonZero
}

func decode(word string, code map[byte]int) int {
	number := 0
	for i := 0; i < len(word); i++ {
		digit, ok := code[word[i]]
		if !ok {
			panic(fmt.Sprintf("Missing Encoding for: %c", word[i]))
		}
		number = number*10 + digit
	}
	return number
}
