package grains

Error :: enum {
	None = 0,
	InvalidSquare,
	Unimplemented,
}

// Returns the number of grains on the specified square.
square :: proc(n: int) -> (u64, Error) {
    if n < 1 || n > 64 { return 0, .InvalidSquare }
	grains := u64(1)
    for i in 2..=n {
        grains = grains << 1
    }
	return grains, .None
}

// Returns the total number of squares on the board.
total :: proc() -> (u64, Error) {
	total_grains := u64(0)
    for i in 1..=64 {
        if grains, error := square(i); error != .None {
            return 0, error
        } else {
            total_grains += grains
        }
    }
    return total_grains, .None
}
