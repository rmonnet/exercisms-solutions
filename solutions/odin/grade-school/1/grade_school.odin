package grade_school

import "core:slice"
import "core:strings"

Class :: [dynamic]string

School :: struct {
	grades:   map[u8]Class,
	students: map[string]bool,
}

Grade :: struct {
	id:       u8,
	students: []string,
}

add :: proc(self: ^School, student: string, grade: u8) -> bool {
	if student in self.students { return false }

	if grade not_in self.grades {
		self.grades[grade] = make(Class)
	}
	self.students[student] = true
	index, _ := slice.binary_search(self.grades[grade][:], student)
	inject_at(&self.grades[grade], index, student)
	return true
}

grade :: proc(self: ^School, id: u8) -> []string {
	return self.grades[id][:]
	// grade, ok := self.grades[id]
	// if ok {
	// 	return grade[:]
	// } else {
	// 	return nil
	// }
}

roster :: proc(self: ^School) -> []Grade {
	roster: [dynamic]Grade
	for id, students in self.grades {
		grade := Grade {
			id       = id,
			students = students[:],
		}
		append(&roster, grade)
	}
	slice.sort_by(roster[:], proc(a, b: Grade) -> bool { return a.id < b.id })
	return roster[:]
}

delete_school :: proc(self: ^School) {

	for _, class in self.grades {
		delete(class)
	}
	delete(self.grades)
	delete(self.students)
}
