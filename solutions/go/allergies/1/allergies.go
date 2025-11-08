package allergies

import (
    "slices"
)

func pow2(n int) uint {
    if n == 0 {
        return 1
    }
    return 2 << (n-1)
}

var allergens = []string{
    "eggs", "peanuts", "shellfish", "strawberries", "tomatoes",
    "chocolate", "pollen", "cats"}

func Allergies(allergies uint) []string {
    // Ignores allergens with higher scores (256, 512, ...)
	allergies = allergies % pow2(len(allergens))
	var res []string
    value := pow2(len(allergens)-1)
    for i := len(allergens)-1; i >= 0; i-- {
        if allergies >= value {
            res = append(res, allergens[i])
            allergies -= value
        }
        value /= 2
    }
    return res
}

func AllergicTo(allergies uint, allergen string) bool {
    return slices.Contains(Allergies(allergies), allergen)
}
