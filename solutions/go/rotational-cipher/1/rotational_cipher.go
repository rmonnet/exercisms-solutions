package rotationalcipher

func RotationalCipher(plain string, shiftKey int) string {
    encodedLetters := make([]rune, len([]rune(plain)))
    for i, letter := range []rune(plain) {
        // Only rotate letters, leave other characters alone.
        if (letter >= 'a' && letter <= 'z') {
        	encodedLetters[i] = (letter - 'a' + int32(shiftKey)) % 26 + 'a'
        } else if (letter >= 'A' && letter <= 'Z') {
			encodedLetters[i] = (letter - 'A' + int32(shiftKey)) % 26 + 'A'
        } else {
            encodedLetters[i] = letter
        }
    }
    return string(encodedLetters)
}
