package cipher

import "strings"

type shift struct {
    distance int32
}

type vigenere struct {
    distances []int32
}

func NewCaesar() Cipher {
	return shift{distance: 3}
}

func NewShift(distance int) Cipher {
    if distance < -25 || distance == 0 || distance > 25 {
        return nil
    }
	return shift{distance: int32(distance)}
}

func (c shift) reverse() Cipher {
    return shift{distance: -c.distance}
}

func (c shift) Encode(input string) string {
	var codedText strings.Builder
    for _, letter := range input {
        codedLetter, ok := encode(letter, c.distance)
        if ok {
            codedText.WriteRune(codedLetter)
        }
    }
    return codedText.String()
}

func (c shift) Decode(input string) string {
    return c.reverse().Encode(input)
}

func NewVigenere(key string) Cipher {
	onlyAFound := true
    res := vigenere{}
    for _, letter:= range key {
        // Only letters a-z are allowed in the key.
        if letter < 'a' || letter > 'z' {
            return nil
        }
        if letter != 'a' {
            onlyAFound = false
        }
        res.distances = append(res.distances, letter - 'a')
    }
    // Keys with only 'a' are not allowed.
    if onlyAFound {
        return nil
    }
    return res
}

func (v vigenere) reverse() Cipher {
    revDist := make([]int32, len(v.distances))
    for i, distance := range v.distances {
        revDist[i] = -distance
    }
    return vigenere{distances: revDist}
}

func (v vigenere) Encode(input string) string {
	var codedText strings.Builder
    keyIndex := 0
    for _, letter := range input {
        codedLetter, ok := encode(letter, v.distances[keyIndex])
        if ok {
            keyIndex = (keyIndex + 1) % len(v.distances)
            codedText.WriteRune(codedLetter)
        }
    }
    return codedText.String()
}

func (v vigenere) Decode(input string) string {
    return v.reverse().Encode(input)
}

func encode(letter rune, distance int32) (rune, bool) {
    var codedLetter rune
    switch {
        case letter >= 'a' && letter <= 'z': codedLetter = letter + distance
        case letter >= 'A' && letter <= 'Z': codedLetter = letter + distance - 'A' + 'a'
        default: return codedLetter, false
    }
    if codedLetter < 'a' {
        codedLetter += 'z' - 'a' + 1
    } else if codedLetter > 'z' {
        codedLetter -= 'z' - 'a' + 1
    }
    return codedLetter, true
}
