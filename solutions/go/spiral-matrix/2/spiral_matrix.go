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
	rdir, cdir := 0, 1
	r, c := 0, 0
	mat := newMatrix(size)
	for i := 0; i < size*size; i++ {
		mat[r][c] = i + 1
        rnext, cnext := r + rdir, c + cdir
        if rnext < 0 || rnext >= size || cnext < 0 || cnext >= size ||
        	mat[rnext][cnext] != 0 {
        	rdir, cdir = cdir, -rdir        
        }
		r += rdir
		c += cdir
	}
	return mat
}
