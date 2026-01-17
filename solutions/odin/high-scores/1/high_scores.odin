package high_scores

import "core:slice"

High_Scores :: struct {
	values: [dynamic]int,
}

new_scores :: proc(initial_values: []int) -> High_Scores {
	scores: High_Scores
	append(&scores.values, ..initial_values)
	return scores
}

destroy_scores :: proc(s: ^High_Scores) {
	delete(s.values)
}

scores :: proc(s: High_Scores) -> []int {
	return slice.clone(s.values[:])
}

latest :: proc(s: High_Scores) -> int {
	if len(s.values) == 0 { return 0 }
	return s.values[len(s.values) - 1]
}

personal_best :: proc(s: High_Scores) -> int {
	if len(s.values) == 0 { return 0 }
	scores := scores(s)
	defer delete(scores)
	slice.sort_by(scores[:], proc(i, j: int) -> bool { return i > j })
	return scores[0]
}

personal_top_three :: proc(s: High_Scores) -> []int {
	scores := scores(s)
	defer delete(scores)
	slice.sort_by(scores[:], proc(i, j: int) -> bool { return i > j })
	best_three: [dynamic]int
	for i := 0; i < 3 && i < len(scores); i += 1 {
		append(&best_three, scores[i])
	}
	return best_three[:]
}
