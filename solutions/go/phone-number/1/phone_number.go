package phonenumber

import (
    "regexp"
    "errors"
    "fmt"
)

var ErrInvalidNumber = errors.New("Invalid phone number")

var phoneNumberRe = regexp.MustCompile(`^(\+?1\s*)?(\([2-9]\d{2}\)|[2-9]\d{2})[\s.]*([2-9]\d{2})[\s-.]*(\d{4})\s*$`)
var areaCodeRe = regexp.MustCompile(`[2-9]\d{2}`)

func parseNumber(phoneNumber string) ([3]string, error) {
    sections := phoneNumberRe.FindStringSubmatch(phoneNumber)
    if sections == nil {
        return [3]string{}, ErrInvalidNumber
    }
    // Remove optional parenthesis around area code.
    areaCode := areaCodeRe.FindString(sections[2])
    return [3]string{areaCode, sections[3], sections[4]}, nil
}

func Number(phoneNumber string) (string, error) {
    sections, err := parseNumber(phoneNumber)
    if err != nil {
        return "", err
    }
	return fmt.Sprintf("%s%s%s", sections[0], sections[1], sections[2]), nil
}

func AreaCode(phoneNumber string) (string, error) {
	sections, err := parseNumber(phoneNumber)
    if err != nil {
        return "", err
    }
	return sections[0], nil
}

func Format(phoneNumber string) (string, error) {
	 sections, err := parseNumber(phoneNumber)
    if err != nil {
        return "", err
    }
	return fmt.Sprintf("(%s) %s-%s", sections[0], sections[1], sections[2]), nil
}
