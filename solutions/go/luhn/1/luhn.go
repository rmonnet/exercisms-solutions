package luhn

func Valid(id string) bool {
    letters := []rune(id)
    sum := 0
    doubleIt := false
    numberDigits := 0
    for i := len(letters)-1; i >= 0; i-- {
        if letters[i] == ' ' {
            // Discard spaces
            continue
        }
        digit := int(letters[i] - '0')
        // Except for space, only digits ('0' to '9') are allowed.
        if digit < 0 || digit > 9 {
            return false
        }
        if doubleIt {
            digit *= 2
            if digit > 9 {
                digit -= 9
            }
        }
        doubleIt = ! doubleIt
        numberDigits++
        sum += digit
    }
    // A single 0 is not allowed (with or without spaces)
    if sum == 0 && numberDigits == 1 {
        return false
    }
    return sum % 10 == 0
}
