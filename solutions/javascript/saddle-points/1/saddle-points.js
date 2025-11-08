

export function saddlePoints(matrix) {

  // Compute the max of each row for later reference.
  const rowMax = [];
  for (const row of matrix) rowMax.push(Math.max(...row))

  // Compute the min of each column for later reference.
  const colMin = [];
  for (let c = 0; c < matrix[0].length; c++) {
    let min = Number.MAX_SAFE_INTEGER;
    for (let r = 0; r < matrix.length; r++) {
      min = Math.min(min, matrix[r][c]);
    }
    colMin.push(min);
  }

  // Now check each cell in the matrix against the max of its row and the min of its column.
  const result = [];
  for (let r = 0; r < matrix.length; r++) {
    for (let c = 0; c < matrix[0].length; c++) {
      const num = matrix[r][c];
      if (num == rowMax[r] && num == colMin[c]) result.push({row: r+1, column: c+1});
    }
  }
  return result;
};
