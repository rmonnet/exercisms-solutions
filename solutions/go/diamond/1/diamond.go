package diamond

import (
    "errors"
    "strings"
    "fmt"
)

func Gen(char byte) (string, error) {
	if char < 'A' || char > 'Z' {
		return "", errors.New("not a valid letter")
	}
    // Since the diamond is symmetric, we only compute the top part and
    // alias the lines on the bottom.
    // We first fill in each line with spaces and then position the
    // two letters on the line.
    //
    // There is no special logic for the middle line (no symmetric line)
    // or the first and last line (only one letter).
    // The logic below just overwrites the central line and letter positions
    // for the first line but the result is the same and it is simpler
    // than adding extra logic to handle the special case.
	nLines := 2*int(char-'A') + 1
	lines := make([][]byte, nLines)
    // Generate an fmt format that results in a line of nLines spaces.
	spaceFormat := fmt.Sprintf("%%-%ds", nLines)
	for i := 0; i <= nLines/2; i++ {
        // Fill in the line with spaces
		lines[i] = []byte(fmt.Sprintf(spaceFormat, ""))
        // The diamond is symmetric, alias the top line to the bottom line.
        lines[nLines-1-i] = lines[i]
		letter := byte('A' + i)
        // Now place the letters on the line.
        // For the first (and last line by symmetry), the two positions
        // are the same but it doesn't matter.
		lines[i][nLines/2 - i] = letter
		lines[i][nLines/2 + i] = letter
	}
    // Now just output as a string
	var out strings.Builder
	for i, line := range lines {
		if i > 0 {
			out.WriteRune('\n')
		}
		out.Write(line)
	}
	return out.String(), nil
}
