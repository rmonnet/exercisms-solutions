package anagram

import (
    "slices"
    "strings"
)

// Letters returns a string containing all the letters in the word
// sorted in alphabetical order and converted to lower case.
//
// Any anagram will return the same value.
func letters(word string) string {
    runes := []rune(strings.ToLower(word))
    slices.Sort(runes)
    return string(runes)
}

// Detect returns the list of words in the candidate list that are anagrams
// of subject.
func Detect(subject string, candidates []string) []string {
	var res = []string{}
    subjectLetters := letters(subject)
    for _, candidate := range candidates {
        // A word can't be an anagram of itself, regardless of case sensitivity.
        if letters(candidate) == subjectLetters &&
        	strings.ToLower(subject) != strings.ToLower(candidate) {
            res = append(res, candidate)
        }   
    }
    return res
}
