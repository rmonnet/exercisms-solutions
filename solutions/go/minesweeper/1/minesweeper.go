package minesweeper

var neighbors = [][2]int{
	{0, 1}, {0, -1}, {1, 0}, {-1, 0}, {1, 1}, {1, -1}, {-1, 1}, {-1, -1}}

// Annotate returns an annotated board.
//
// We are assuming the input board is rectangular and that the board only contains
// ASCII characters space and star (1 byte each).
func Annotate(board []string) []string {
	if len(board) == 0 {
		return nil
	}
	nrows, ncols := len(board), len(board[0])
	res := make([]string, nrows)
	for r := 0; r < nrows; r++ {
		row := make([]rune, ncols)
		for c := 0; c < ncols; c++ {
			if board[r][c] == '*' {
				row[c] = '*'
				continue
			}
			sum := 0
			for _, n := range neighbors {
				rn := r + n[0]
				cn := c + n[1]
				// Don't wrap around the board when looking for neighbors.
				if rn < 0 || rn >= nrows || cn < 0 || cn >= ncols {
					continue
				}
				if board[rn][cn] == '*' {
					sum++
				}
			}
			if sum == 0 {
				row[c] = ' '
			} else {
				row[c] = '0' + rune(sum)
			}
		}
		res[r] = string(row)
	}
	return res
}
