package hamming

Error :: enum {
	None,
	UnequalLengths,
	Unimplemented,
}

distance :: proc(strand1, strand2: string) -> (int, Error) {

    if len(strand1) != len(strand2) { return 0, .UnequalLengths}
    
	// We can assume the strands only contain ASCII characters
    distance := 0
    for i in 0..<len(strand1) {
    if strand1[i] != strand2[i] {
        distance += 1
        }
    }
    return distance, .None
}

