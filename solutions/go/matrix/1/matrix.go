package matrix

import (
    "errors"
    "strings"
    "strconv"
)

// Matrix represents a matrix of integer.
//
// Note: the tests are written in such a way that Matrix is compared to nil
// so we can't define a type more sophisticated like a struct with fields
// for number of rows or columns. Such attempt will cause a compile error
// in the exercise tests.
type Matrix [][]int

func New(s string) (Matrix, error) {
    res := Matrix{}
    rows := strings.Split(s, "\n")
    var ncols int
    for i, row := range rows {
        values := strings.Split(strings.Trim(row, " "), " ")
        if i == 0 {
            ncols = len(values)
        } else {
            if ncols != len(values) {
                return nil, errors.New("Matrix is not square")
            }
        }
    	row := make([]int, ncols)
        for j, value := range values {
            if ival, err := strconv.Atoi(value); err != nil {
                return nil, err
            } else {
            	row[j] = ival
            }
        }
        res = append(res, row)
    }
    return res, nil
}

// Cols and Rows must return the results without affecting the matrix.
func (m Matrix) Cols() [][]int {
	res := make([][]int, len(m[0]))
    for c := 0; c < len(m[0]); c++ {
        res[c] = make([]int, len(m))
        for r := 0; r < len(m); r++ {
            res[c][r] = m[r][c]
        }
    }
    return res
}

func (m Matrix) Rows() [][]int {
    res := make([][]int, len(m))
    for r := 0; r < len(m); r++ {
        res[r] = make([]int, len(m[0]))
        copy(res[r], m[r])
    }
	return res
}

func (m Matrix) Set(row, col, val int) bool {
	if row < 0 || row >= len(m) || col < 0 || col >= len(m[0]) {
        return false
    }
    m[row][col] = val
    return true
}
