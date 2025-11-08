package spiralmatrix

type Matrix = [][]int

func newMatrix(size int) Matrix {
	res := make(Matrix, size)
	for i := 0; i < size; i++ {
		res[i] = make([]int, size)
	}
	return res
}

func SpiralMatrix(size int) [][]int {
	colMin, colMax := 0, size - 1
	rowMin, rowMax := 1, size -1
	rowDir, colDir := 0, 1
	row, col := 0, 0
	mat := newMatrix(size)
	for i := 0; i < size*size; i++ {
		mat[row][col] = i + 1
		row += rowDir
		col += colDir
		switch {
		case colDir == 1 && col == colMax:
			rowDir, colDir = 1, 0
			colMax--
		case rowDir == 1 && row == rowMax:
			rowDir, colDir = 0, -1
			rowMax--
		case colDir == -1 && col == colMin:
			rowDir, colDir = -1, 0
			colMin++
		case rowDir == -1 && row == rowMin:
			rowDir, colDir = 0, 1
			rowMin++
		}
	}
	return mat
}
