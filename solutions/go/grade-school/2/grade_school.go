package school

import (
    "cmp"
    "slices"
    "sort"
)

// Define the Grade and School types here.
type Grade struct {
    level int
    students []string
}

type School struct {
    classes map[int]*Grade
}

func New() *School {
	return &School{classes: map[int]*Grade{}}
}

func (s *School) Add(student string, grade int) {
	class, ok := s.classes[grade]
    if !ok {
        class = &Grade{level: grade}
        s.classes[grade] = class
    }
    class.students = append(class.students, student)
}

func (s *School) Grade(grade int) []string {
	class, ok := s.classes[grade]
    if !ok {
        return []string{}
    }
    return class.students
}

func (s *School) Enrollment() []Grade {
    byAscendingGrade := func(a, b Grade) int {
         return cmp.Compare(a.level, b.level)
    }
	res := []Grade{}
    for _, class := range s.classes {
    	sort.Strings(class.students)
        res = append(res, *class)
    }
    slices.SortFunc(res, byAscendingGrade)
    return res
}
