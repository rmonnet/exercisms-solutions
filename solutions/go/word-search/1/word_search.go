package wordsearch

import (
    "strings"
    "errors"
)

// We are assuming that some of the words can be non ASCII so we are treating
// all the lines as UTF8.


type ResultMap = map[string][2][2]int

var WordNotFound = errors.New("word not found")

var PuzzleNotRectangular = errors.New("puzzle is not rectangular")

func mod(n, m int) int {
    for n >= m {
        n -= m
    }
    for n < 0 {
        n += m
    }
	return n
}

type transformFn func(r1, c1 int) (r0, c0 int)

type dimFn func() (nrows1, ncols1 int)

type strategy func(nrows, ncols int) (transformFn, dimFn)

func leftToRight(nrows0, ncols0 int) (transformFn, dimFn) {
    trfn := func(r1, c1 int) (int, int) {
        return r1, c1
    }
    dfn := func() (int, int) {
        return nrows0, ncols0
    }
    return trfn, dfn
}

func rightToLeft(nrows0, ncols0 int) (transformFn, dimFn) {
    trfn := func(r1, c1 int) (int, int) {
        return r1, ncols0 -1 - c1
    }
    dfn := func() (int, int) {
        return nrows0, ncols0
    }
    return trfn, dfn
}

func topToBottom(nrows0, ncols0 int) (transformFn, dimFn) {
    trfn := func(r1, c1 int) (int, int) {
        return c1, r1
    }
    dfn := func() (int, int) {
        return ncols0, nrows0
    }
    return trfn, dfn
}

func bottomToTop(nrows0, ncols0 int) (transformFn, dimFn) {
    trfn := func(r1, c1 int) (int, int) {
        return nrows0 - 1 - c1, r1
    }
    dfn := func() (int, int) {
        return ncols0, nrows0
    }
    return trfn, dfn
}

func topLeftToBottomRight(nrows0, ncols0 int) (transformFn, dimFn) {
    trfn := func(r1, c1 int) (int, int) {
        return c1, mod(c1 + r1, ncols0)
    }
    dfn := func() (int, int) {
        return ncols0, nrows0
    }
    return trfn, dfn
}

func topRightToBottomLeft(nrows0, ncols0 int) (transformFn, dimFn) {
    trfn := func(r1, c1 int) (int, int) {
        return c1, mod(nrows0 - 1 - c1 - r1, ncols0)
    }
    dfn := func() (int, int) {
        return ncols0, nrows0
    }
    return trfn, dfn
}

func bottomLeftToTopRight(nrows0, ncols0 int) (transformFn, dimFn) {
    trfn := func(r1, c1 int) (int, int) {
        return nrows0 -1 - c1, mod(c1 + r1, ncols0)
    }
    dfn := func() (int, int) {
        return ncols0, nrows0
    }
    return trfn, dfn
}

func bottomRightToTopLeft(nrows0, ncols0 int) (transformFn, dimFn) {
    trfn := func(r1, c1 int) (int, int) {
        return nrows0 -1 - c1, mod(nrows0 - 1 - c1 - r1, ncols0)
    }
    dfn := func() (int, int) {
        return ncols0, nrows0
    }
    return trfn, dfn
}

var strategies = []strategy{
    leftToRight, rightToLeft, topToBottom, bottomToTop,
    topLeftToBottomRight, bottomRightToTopLeft, bottomLeftToTopRight, 
    topRightToBottomLeft}

func toMatrix(puzzle []string) [][]rune {
    res := make([][]rune, len(puzzle))
    for i, line := range puzzle {
        res[i] = []rune(line)
    }
    return res
}

func newMatrix(nrows, ncols int) [][]rune {
    res := make([][]rune, nrows)
    for r := 0; r < nrows; r++ {
        res[r] = make([]rune, ncols)
    }
    return res
}

func fromMatrix(matrix [][]rune) []string {
    res := make([]string, len(matrix))
    for i, line := range matrix {
        res[i] = string(line)
    }
    return res
}

func transformPuzzle(puzzle []string, transform transformFn, dims dimFn) []string {
    puzzleMat := toMatrix(puzzle)
	nrows1, ncols1 := dims()
    transMat := newMatrix(nrows1, ncols1)
    for r1 := 0; r1 < nrows1; r1++ {
        for c1 := 0; c1 < ncols1; c1++ {
            r0, c0 := transform(r1, c1)
            transMat[r1][c1] = puzzleMat[r0][c0]
        }
    }
    return fromMatrix(transMat)
}

func isRectangular(puzzle []string) bool {
    linelen := len(puzzle[0])
    for _, line := range puzzle {
        if linelen != len(line) {
            return false
        }
    }
    return true
}

func search(result ResultMap, words []string, puzzle []string, transform transformFn) {
    for _, word := range words {
        for lineno, line := range puzzle {
        	if index := strings.Index(line, word); index >= 0 {
                startLine, startCol := transform(lineno, index)
                endLine, endCol := transform(lineno, index+len(word)-1)
                result[word] = [2][2]int{{startCol, startLine}, {endCol, endLine}}
            }
    	}
    }
}

func solve(result ResultMap, words []string, puzzle []string, st strategy) {
    nrows, ncols := len(puzzle), len(puzzle[0])
    transform, dims := st(nrows, ncols)
    trPuzzle := transformPuzzle(puzzle, transform, dims)
    search(result, words, trPuzzle, transform)
}

func Solve(words []string, puzzle []string) (ResultMap, error) {
    if !isRectangular(puzzle) {
        return nil, PuzzleNotRectangular
    }
    res := make(ResultMap)
    for _, st := range strategies {
        solve(res, words, puzzle, st)
    }
    if len(res) < len(words) {
        return nil, WordNotFound
    }
    return res, nil
}

