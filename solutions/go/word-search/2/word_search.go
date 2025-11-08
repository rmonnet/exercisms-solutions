package wordsearch

import (
    "bytes"
    "errors"
)

// We are assuming that all the words are ASCII so we can manipulate strings
// are arrays of bytes.

// We are defining each way to search the puzzle (left-to-right, right-to-left, ...)
// as a strategy. We define a way to convert a row/col from a specific reference frame
// (i.e. right-to-left or top-to-bottom) to the original puzzle (left-to-right).
// We use that strategy to convert the puzzle into the given coordinate system
// which make searching for the text trivial.

// Mod ensures n is within the range [0, m).
// Mod is used when converting row/col indexes between reference frames.
func mod(n, m int) int {
    for n >= m {
        n -= m
    }
    for n < 0 {
        n += m
    }
	return n
}

// Solution defines a type alias for the Solution of Solve().
type Solution = map[string][2][2]int

// Matrix represents the puzzle text as a matrix.
type Matrix = [][]byte

// TransformFn defines the type of function to convert row/col from
// a new reference frame back to the original.
type transformFn func(r1, c1 int) (r0, c0 int)

// DimFn defines the type of a function that compute the row/col dimensions
// in a given reference frame.
type dimFn func() (nrows1, ncols1 int)

// Strategy defines the type of a function returning, for a given reference frame,
// a function transforming row/col back to the original system and a function
// computing the row/col dimensions in the reference frame.
type strategy func(nrows, ncols int) (transformFn, dimFn)

// Strategy function to search the puzzle left to right.
func leftToRight(nrows0, ncols0 int) (trfn transformFn, dfn dimFn) {
    trfn = func(r1, c1 int) (int, int) {
        return r1, c1
    }
    dfn = func() (int, int) {
        return nrows0, ncols0
    }
    return
}

// Strategy function to search the puzzle right to left.
func rightToLeft(nrows0, ncols0 int) (trfn transformFn, dfn dimFn) {
    trfn = func(r1, c1 int) (int, int) {
        return r1, ncols0 -1 - c1
    }
    dfn = func() (int, int) {
        return nrows0, ncols0
    }
    return
}

// Strategy function to search the puzzle top to bottom.
func topToBottom(nrows0, ncols0 int) (trfn transformFn, dfn dimFn) {
    trfn = func(r1, c1 int) (int, int) {
        return c1, r1
    }
    dfn = func() (int, int) {
        return ncols0, nrows0
    }
    return
}

// Strategy function to search the puzzle bottom to top.
func bottomToTop(nrows0, ncols0 int) (trfn transformFn, dfn dimFn) {
    trfn = func(r1, c1 int) (int, int) {
        return nrows0 - 1 - c1, r1
    }
    dfn = func() (int, int) {
        return ncols0, nrows0
    }
    return
}

// Strategy function to search the puzzle in diagonal (top left to bottom right).
func topLeftToBottomRight(nrows0, ncols0 int) (trfn transformFn, dfn dimFn) {
    trfn = func(r1, c1 int) (int, int) {
        return c1, mod(c1 + r1, ncols0)
    }
    dfn = func() (int, int) {
        return ncols0, nrows0
    }
    return
}

// Strategy function to search the puzzle in diagonal (top right to bottom left)
func topRightToBottomLeft(nrows0, ncols0 int) (trfn transformFn, dfn dimFn) {
    trfn = func(r1, c1 int) (int, int) {
        return c1, mod(nrows0 - 1 - c1 - r1, ncols0)
    }
    dfn = func() (int, int) {
        return ncols0, nrows0
    }
    return
}

// Strategy function to search the puzzle in diagonal (bottom left to top right)
func bottomLeftToTopRight(nrows0, ncols0 int) (trfn transformFn, dfn dimFn) {
    trfn = func(r1, c1 int) (int, int) {
        return nrows0 -1 - c1, mod(c1 + r1, ncols0)
    }
    dfn = func() (int, int) {
        return ncols0, nrows0
    }
    return
}

// Strategy function to search the puzzle in diagonal (bottom right to top left)
func bottomRightToTopLeft(nrows0, ncols0 int) (trfn transformFn, dfn dimFn) {
    trfn = func(r1, c1 int) (int, int) {
        return nrows0 -1 - c1, mod(nrows0 - 1 - c1 - r1, ncols0)
    }
    dfn = func() (int, int) {
        return ncols0, nrows0
    }
    return
}

// strategies is a list of all the strategies to use when searching the puzzle.
var strategies = []strategy{
    leftToRight, rightToLeft, topToBottom, bottomToTop,
    topLeftToBottomRight, bottomRightToTopLeft, bottomLeftToTopRight, 
    topRightToBottomLeft}

// TransformPuzzle converts the original puzzle to a puzzle in the given
// reference frame.
func transformPuzzle(puzzleMat Matrix, transform transformFn, dims dimFn) Matrix {
	nrows1, ncols1 := dims()
    res := make(Matrix, nrows1)
    for r1 := 0; r1 < nrows1; r1++ {
        res[r1] = make([]byte, ncols1)
        for c1 := 0; c1 < ncols1; c1++ {
            r0, c0 := transform(r1, c1)
            res[r1][c1] = puzzleMat[r0][c0]
        }
    }
    return res
}

// IsRectangular checks that the input puzzle is a rectangle
// (i.e. all the rows have the same length).
func isRectangular(puzzle []string) bool {
    linelen := len(puzzle[0])
    for _, line := range puzzle {
        if linelen != len(line) {
            return false
        }
    }
    return true
}

// ToMatrix converts the original puzzle to a matrix (2D array)
// of bytes. This makes transformations between reference frames easier.
func toMatrix(puzzle []string) Matrix {
    res := make(Matrix, len(puzzle))
    for i, line := range puzzle {
        res[i] = []byte(line)
    }
    return res
}

// Search finds all the solutions for a given reference frame.
func search(result Solution, words []string, puzzle Matrix, transform transformFn) {
    for _, word := range words {
        wordAsBytes := []byte(word)
        for lineno, line := range puzzle {
        	if index := bytes.Index(line, wordAsBytes); index >= 0 {
                startLine, startCol := transform(lineno, index)
                endLine, endCol := transform(lineno, index+len(word)-1)
                result[word] = [2][2]int{{startCol, startLine}, {endCol, endLine}}
            }
    	}
    }
}

// Solve finds all the words in the puzzle searching with one of the given
// strategies. It returns an error if some of the words can't be found,
func Solve(words []string, puzzle []string) (Solution, error) {
    if !isRectangular(puzzle) {
        return nil, errors.New("puzzle is not rectangular")
    }
    res := make(Solution)
    nrows, ncols := len(puzzle), len(puzzle[0])
    puzzleMat := toMatrix(puzzle)
    for _, st := range strategies {
        transform, dims := st(nrows, ncols)
        trPuzzle := transformPuzzle(puzzleMat, transform, dims)
        search(res, words, trPuzzle, transform)
    }
    if len(res) < len(words) {
        return nil, errors.New("word not found")
    }
    return res, nil
}

