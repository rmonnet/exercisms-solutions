package encode

import (
    "strings"
    "strconv"
    "regexp"
)

// CodedLetterRe represents the regular expression for a coded letter.
// It represents either 'nX' where n is an integer or 'X' where n is implicitely
// equal to 1.
var codedLetterRe = regexp.MustCompile(`((\d*)([\w ]))`)

// EncodeLetter encodes a single letter with a count n by outputing 'nX'.
// If n is 1, then the output is 'X' (1 is implicit).
func encodeLetter(b *strings.Builder, letter rune, count int) {
    if count == 0 {
        return
    }
    if count > 1 {
		b.WriteString(strconv.Itoa(count))
    }
    b.WriteRune(letter)    
}

// DecodeLetter decodes a letter by outputing it value n time.
func decodeLetter(b *strings.Builder, letter string, count int) {
	for i := 0; i < count; i++ {
        b.WriteString(letter)
    }    
}

// RunLengthEncode encodes a string using the Run Length encoding (see instructions
// for a description of Run Lengh encoding).
func RunLengthEncode(input string) string {
	var res strings.Builder
    var count int
    var currentLetter rune
    for _, letter := range input {
        if currentLetter != letter {
            encodeLetter(&res, currentLetter, count)
            count = 1
            currentLetter = letter
        } else {
            count++
        }
    }
    encodeLetter(&res, currentLetter, count)
    return res.String()
}
// RunLengthDecode decodes a string using the Run Length encoding (see instructions
// for a description of Run Lengh encoding).
func RunLengthDecode(input string) string {
    codedLetters := codedLetterRe.FindAllStringSubmatch(input, -1)
    if codedLetters == nil {
        return ""
    }
    var res strings.Builder
    for _, codedLetter := range codedLetters {
        count := 1
        // the number 1 in front of an encoded letter is omitted.
        if len(codedLetter[2]) > 0 {
        	// the definition of codedLetterRe ensures that codedLetter[2] is a string
            // of digits so we can assume the error returned by Atoi is always nil.
            count, _ = strconv.Atoi(codedLetter[2])
        }
        decodeLetter(&res, codedLetter[3], count)
    }
	return res.String()
}
