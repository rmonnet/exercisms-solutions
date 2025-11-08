package allergies


var allergens = map[string]uint{}

func init() {
    names := []string{"eggs", "peanuts", "shellfish", "strawberries", "tomatoes",
                      "chocolate", "pollen", "cats"}
	for i, name := range names {
        allergens[name] = 1 << i
    }
}

func Allergies(allergies uint) []string {
	res := []string{}
    for name, value := range allergens {
        if allergies & value != 0 {
            res = append(res, name)
        }
    }
    return res
}

func AllergicTo(allergies uint, allergen string) bool {
    return allergies & allergens[allergen] != 0
}
