package isbn

import "regexp"

var digits = map[string]int{"0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6,
                           "7": 7, "8": 8, "9": 9, "X": 10}

var isbnRe = regexp.MustCompile(
    `^(\d)[\s-]*(\d)(\d)(\d)[\s-]*(\d)(\d)(\d)(\d)(\d)[\s-]*([\dX])$`)

func IsValidISBN(isbn string) bool {
	parts :=  isbnRe.FindStringSubmatch(isbn)
    if len(parts) != 11 {
        return false
    }
    checksum := 0
    for i := 0; i < 10; i++ {
        checksum += digits[parts[i+1]] * (10-i)
    }
    return checksum % 11 == 0
}
