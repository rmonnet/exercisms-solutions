package anagram

import "core:slice"
import "core:strings"
import "core:unicode/utf8"

find_anagrams :: proc(word: string, candidates: []string) -> []string {

	word_lc := strings.to_lower(word)
	defer delete(word_lc)

	word_letters := to_letters(word_lc)
	defer delete(word_letters)

	anagrams: [dynamic]string
	for candidate in candidates {
		candidate_lc := strings.to_lower(candidate)
		defer delete(candidate_lc)
		if word_lc != candidate_lc && letters_match(word_letters, candidate_lc) {
			append(&anagrams, candidate)
		}
	}
	return anagrams[:]
}

letters_match :: proc(word_letters: []rune, candidate: string) -> bool {

	candidate_letters := to_letters(candidate)
	defer delete(candidate_letters)
	return slice.equal(word_letters, candidate_letters)
}

to_letters :: proc(word: string) -> []rune {

	word_letters := utf8.string_to_runes(word)
	slice.sort(word_letters)
	return word_letters
}
