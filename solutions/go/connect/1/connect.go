package connect

import (
	"errors"
	"regexp"
)

// The Connex grid is NxN and slanted towards East.
// The possible moves (when trying to connect the sides are E, W, NE, NW, SE, SW).
// We can simplify the problem by rectifying the grid (i.e. not slanted to the right).
// We do this by removing the left spaces on each line.
// Because the original grid is slanted to the right and the new one is not, we have to translate
// the 6 possible moves to the new grid.
// E: col+1
// W: col-1
// NE: row-1, col+1
// NW: row-1 (we don't change the column because the move west is compensated by the slant of the grid)
// SE: row+1 (we don't change the column because the move east is compensated by the slant of the grid)
// SW: row+1, col-1
//
// We use a backtrack algorithm but keep track of nodes we have already explored.

// ResultOf returns the name of the winning player or "" if nobody wins.
// It returns an error if the input contains illegal characters (i.e. different from 'X', 'O', or '.').
// or if the input is not a rectangular grid (lines of different length).
func ResultOf(lines []string) (string, error) {
	grid, err := NewGrid(lines)
	if err != nil {
		return "", err
	}
	for _, player := range []rune{'X', 'O'} {
		if grid.win(player) {
			return string(player), nil
		}
	}
	return "", nil
}

// Win checks if a player won.
// To win a player needs to have a continuous path of stones
// from one of its starting cell to one of its ending cell.
func (g grid) win(player rune) bool {
	tried := map[cell]bool{}
	for _, c := range g.startCells(player) {
		if g.value(c) != player {
			tried[c] = true
			continue
		}
		path := []cell{c}
		if g.backtrack(player, path, tried) {
			return true
		}
	}
	return false
}

// Backtrack searches if there is a path from the last cell in path to one
// of the player ending cell.
// Backtrack used path to avoid retracing its step and tried to prune exploring path
// from cells that already failed to reach an ending cell (in previous backtrack calls).
func (g grid) backtrack(player rune, path []cell, tried map[cell]bool) bool {
	curCell := path[len(path)-1]
	if g.isEndCell(player, curCell) {
		return true
	}
	for _, dir := range moves {
		nextCell := curCell.move(dir)
		if tried[nextCell] || !g.inBound(nextCell) || g.value(nextCell) != player || nextCell.inPath(path) {
			continue
		}
		newPath := append(path, nextCell)
		if g.backtrack(player, newPath, tried) {
			return true
		} else {
			tried[nextCell] = true
		}

	}
	return false
}

// Moves represents the different moves allowed in X ({delta row, delta col}).
var moves = []cell{{0, 1}, {0, -1}, {-1, 1}, {-1, 0}, {1, 0}, {1, -1}}

// Cell represents the coordinate of a cell in the grid.
type cell struct {
	row int
	col int
}

// Move generate the target cell for one of the allowed move defined above.
func (c cell) move(dir cell) cell {
	return cell{c.row + dir.row, c.col + dir.col}
}

// InPath checks if a cell is already in the given path.
// This avoids the algorithm retracing its steps and creating an infinite loop.
func (c cell) inPath(path []cell) bool {
	for _, pcell := range path {
		if c == pcell {
			return true
		}
	}
	return false
}

// Grid represents the hex board including the stones played.
type grid [][]rune

// ValidLineRe is a regular expression use to check if a row in the problem hex is valid.
var validLineRe = regexp.MustCompile(`^[.XO]+$`)

// NewGrid converts the input to a grid.
// It returns errors if the grid contains invalid characters or is not rectangular.
func NewGrid(lines []string) (grid, error) {
	grid := make([][]rune, len(lines))
	var ncols int
	for i, line := range lines {
		if !validLineRe.MatchString(line) {
			return nil, errors.New("grid contains invalid character")
		}
		row := []rune(line)
		if i == 0 {
			ncols = len(row)
		}
		if len(row) != ncols {
			return nil, errors.New("grid is not rectangular")
		}
		grid[i] = row
	}
	return grid, nil
}

// InBound checks if a cell is contained in the grid.
// This is used to trim invalid moves when the current cell is near on of the edge.
func (g grid) inBound(c cell) bool {
	return c.row >= 0 && c.row < len(g) && c.col >= 0 && c.col < len(g[0])
}

// Value returns the stone located at the cell location.
func (g grid) value(c cell) rune {
	return g[c.row][c.col]
}

// BeginCells returns a list of all the candidate starting cells for a player
// (for O the top row, for X the left column).
func (g grid) startCells(player rune) []cell {
	res := []cell{}
	switch player {
	case 'X':
		for r := 0; r < len(g); r++ {
			res = append(res, cell{r, 0})
		}
	case 'O':
		for c := 0; c < len(g[0]); c++ {
			res = append(res, cell{0, c})
		}
	}
	return res
}

// IsEndCell checks if the cell is an end (winning) cell for the player
// (for O the bottom row, for X the right column).
func (g grid) isEndCell(player rune, c cell) bool {
	switch player {
	case 'X':
		return c.col == len(g[0])-1
	case 'O':
		return c.row == len(g)-1
	default:
		return false
	}
}
