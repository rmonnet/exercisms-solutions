package etl

import "strings"

func Transform(in map[int][]string) map[string]int {
	values := map[string]int {}
    for point, letters := range in {
        for _, letter := range letters {
            values[strings.ToLower(letter)] = point
        }
    }
    return values
}
