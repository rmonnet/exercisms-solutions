package isbn_verifier

import "core:text/regex"
is_valid :: proc(isbn: string) -> bool {

	re, err := regex.create(`^(\d)-?(\d{3})-?(\d{5})-?([0-9X])$`)
	defer regex.destroy_regex(re)
	assert(err == nil)
	capture, ok := regex.match(re, isbn)
	defer regex.destroy_capture(capture)
	if !ok { return false }
	// checksum: d₁*10 + d₂*9 + d₃*8 + d₄*7 + d₅*6 + d₆*5 + d₇*4 + d₈*3 + d₉*2 + d₁₀*1
	checksum: int = 10 * int(capture.groups[1][0] - '0')
	for i in 0 ..< 3 {
		checksum += (9 - i) * int(capture.groups[2][i] - '0')
	}
	for i in 0 ..< 5 {
		checksum += (6 - i) * int(capture.groups[3][i] - '0')
	}
	if capture.groups[4][0] == 'X' {
		checksum += 10
	} else {
		checksum += int(capture.groups[4][0] - '0')
	}
	return checksum % 11 == 0
}
