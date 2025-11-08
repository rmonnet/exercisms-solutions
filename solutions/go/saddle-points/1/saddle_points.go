package matrix

import (
    "errors"
    "strings"
    "strconv"
)

// Matrix defines a rectangular grid of height measurements.
type Matrix [][]int

// Pair represents a Pair of [row, col] elements.
type Pair = [2]int

// LargestIndexesInRow computes the set of indexes associated with the
// largest height values in a given row.
func largestIndexesInRow(m *Matrix, row int) [] int {
    // Loop twice: first find the max value, then collect all the indexes
    // the max value.
	max := (*m)[row][0]
    for _, value := range (*m)[row] {
        if value > max {
            max = value
        }
    }
    res := []int{}
    for i, value := range (*m)[row] {
        if value == max {
            res = append(res, i)
        }
    }
    return res
}

// SmallestValueInCol returns the min height for a given column.
func smallestValueInCol(m *Matrix, col int) int {
    min := (*m)[0][col]
    for r := 1; r < len(*m); r++ {
        if (*m)[r][col] < min {
            min = (*m)[r][col]
        }
    }
    return min
}

// New parses a grid of height and returns a Matrix.
// It returns an error if the matrix is not rectangular or contains
// invalid height measurements.
func New(s string) (*Matrix, error) {
    if len(s) == 0 {
        return &Matrix{}, nil
    }
    rows := strings.Split(s, "\n")
    res := make(Matrix, len(rows))
    var ncols int
    for i, row := range rows {
        heights := strings.Split(strings.Trim(row, " "), " ")
        if i == 0 {
            ncols = len(heights)
        } else if len(heights) != ncols {
        	return nil, errors.New("matrix must be rectangular")
        }
        res[i] = make([]int, ncols)
        for j, height := range heights {
            var err error
            res[i][j], err = strconv.Atoi(height)
            if err != nil {
                return nil, errors.New("matrix must only contains numerical values")
            }
        }
    }
    return &res, nil
}

// Saddle returns the pairs [row, col] of the best positions to build a tree house.
func (m *Matrix) Saddle() []Pair {
	res := []Pair{}
    for r := 0; r < len(*m); r++ {
        indexes := largestIndexesInRow(m, r)
        for _, index := range indexes {
            if (*m)[r][index] == smallestValueInCol(m, index) {
                // Pair index are 1-based, Matrix is 0-based.
                res = append(res, Pair{r+1, index+1})
            }
        }
    }
    return res
}
