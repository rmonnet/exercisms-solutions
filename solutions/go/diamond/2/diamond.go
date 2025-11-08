package diamond

import (
    "errors"
    "strings"
    "fmt"
)

func Gen(char byte) (string, error) {
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
    
    if char < 'A' || char > 'Z' {
		return "", errors.New("not a valid letter")
	}
	nLines := 2 * int(char-'A') + 1
	lines := make([]string, nLines)
	for i := 0; i <= nLines/2; i++ {
		line := []byte(fmt.Sprintf("%[2]*[1]s", "", nLines))
		letter := byte('A' + i)
		line[nLines/2 - i] = letter
		line[nLines/2 + i] = letter
        lines[i] = string(line)
        lines[nLines-1-i] = lines[i]
	}
	return strings.Join(lines, "\n"), nil
}
