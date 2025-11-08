
export class Matrix {
  constructor(matrixAsString) {
    this.matrix = matrixAsString.split('\n').map(row => row.split(' ').map(n => Number(n)));
    this.transpose = undefined;
  }

  get rows() {
    return this.matrix;
  }

  get columns() {
    if (this.transpose === undefined) this._transpose();
    return this.transpose;
  }

  // Transposes the matrix (switch rows and columns) once.
  // This is overkill for this exercise but in a real library we would want to avoid
  // repeating this operation on the same matrix
  _transpose() {
    
    const nrows = this.matrix.length;
    const ncols = this.matrix[0].length;

    // initialize an empty matrix of ncols (array of array)
    this.transpose = [];
    for (let i = 0; i < ncols; i++) {
      this.transpose[i] = [];
    }

    // transpose all the elements
    for (let r = 0; r < nrows; r++) {
      for (let c = 0; c < ncols; c++) {
        this.transpose[c][r] = this.matrix[r][c];
      }
    }
  }
}
