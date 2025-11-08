package kindergarten

import (
    "strings"
    "sort"
    "errors"
    "regexp"
)

var validPlantsRe = regexp.MustCompile(`^[GCRV]+$`)

var plants = map[byte]string{
    'G': "grass", 'C': "clover", 'R': "radishes", 'V': "violets"}

type Garden map[string][]string

// The diagram argument starts each row with a '\n'.  This allows Go's
// raw string literals to present diagrams in source code nicely as two
// rows flush left, for example,
//
//     diagram := `
//     VVCCGG
//     VVCCGG`

func NewGarden(diagram string, children []string) (*Garden, error) {
	rows := strings.Split(diagram, "\n")
    if len(rows) != 3 || len(rows[0]) != 0 {
        return nil, errors.New("Expected two rows")
    }
    if len(rows[1]) != len(rows[2]) {
        return nil, errors.New("Expected the two rows to have the same size")
    }
    if len(rows[1]) != 2*len(children) || len(rows[2]) != 2*len(children) {
        return nil, errors.New("Expected rows to have 2 slots per child")
    }
    if !validPlantsRe.MatchString(rows[1]) || !validPlantsRe.MatchString(rows[2]) {
        return nil, errors.New("Invalid plant in diagram")
    }
    // Children must be sorted by alphabetical order.
    students := make([]string, len(children))
    copy(students, children)
    sort.Strings(students)
    garden := make(Garden)
    for i, student := range students {
        // Make sure there is no duplicate names in the class.
        if _, ok := garden[student]; ok {
            return nil, errors.New("Duplicate children names")
        }
        garden[student] = []string{
            plants[rows[1][2*i]], plants[rows[1][2*i+1]],
            plants[rows[2][2*i]], plants[rows[2][2*i+1]]}
    }
    return &garden, nil
}

func (g *Garden) Plants(child string) ([]string, bool) {
	plants, ok := (*g)[child]
    return plants, ok
}
