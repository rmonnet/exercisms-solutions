package stringset

import (
    "strings"
)

// Implement Set as a collection of unique string values.
//
// For Set.String, use '{' and '}', output elements as double-quoted strings
// safely escaped with Go syntax, and use a comma and a single space between
// elements. For example, a set with 2 elements, "a" and "b", should be formatted as {"a", "b"}.
// Format the empty set as {}.

type Set map[string]struct{}

func New() Set {
	return make(Set)
}

func NewFromSlice(l []string) Set {
	res := New()
    for _, e := range l {
        res.Add(e)
    }
    return res
}

func (s Set) String() string {
    var res strings.Builder
    res.WriteString("{")
	first := true
    for e, _ := range s {
        if first {
            first = false
        } else {
            res.WriteString(", ")
        }
        res.WriteString("\"")
        res.WriteString(e)
        res.WriteString("\"")
    }
    res.WriteString("}")
    return res.String()
}

func (s Set) IsEmpty() bool {
	return len(s) == 0
}

func (s Set) Has(elem string) bool {
	_, ok := s[elem]
    return ok
}

func (s Set) Add(elem string) {
	s[elem] = struct{}{}
}

func Subset(s1, s2 Set) bool {
	for e1, _ := range s1 {
        if ! s2.Has(e1) {
            return false
        }
    }
    return true
}

func Disjoint(s1, s2 Set) bool {
	for e1, _ := range s1 {
        if s2.Has(e1) {
            return false
        }
    }
    return true
}

func Equal(s1, s2 Set) bool {
	return Subset(s1, s2) && Subset(s2, s1)
}

func Intersection(s1, s2 Set) Set {
	res := New()
    for e1, _ := range s1 {
        if s2.Has(e1) {
            res.Add(e1)
        }
    }
    return res
}

func Difference(s1, s2 Set) Set {
	res := New()
    for e1, _ := range s1 {
        if ! s2.Has(e1) {
            res.Add(e1)
        }
    }
    return res
}

func Union(s1, s2 Set) Set {
	res := New()
    for e1, _ := range s1 {
        res.Add(e1)
    }
    for e2, _ := range s2 {
        res.Add(e2)
    }
    return res
}
