package collatz_conjecture

LIMIT :: 1_000_000

// Returns the number of steps to get to a value of 1.
steps :: proc(start: int) -> (result: int, ok: bool) {
	if start < 1 { return 0, false}
    steps:= 0
    n := start
    for n > 1 && steps < LIMIT {
        steps += 1
        n = next_step(n)
    }
    if steps == LIMIT { return 0, false}
    return steps, true
}

next_step :: proc(n: int) -> int {

    return n % 2 == 0 ? n / 2 : 3 * n + 1
}