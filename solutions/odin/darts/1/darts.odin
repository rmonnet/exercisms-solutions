package darts

import m "core:math"

score :: proc(x, y: f64) -> int {

	d := distance(x, y)
	score := 0
	switch {
	case d <= 1:
		score = 10
	case d <= 5:
		score = 5
	case d <= 10:
		score = 1
	}
	return score
}

distance :: proc(x, y : f64) -> f64 {

	return m.sqrt(x*x + y*y)	
}
