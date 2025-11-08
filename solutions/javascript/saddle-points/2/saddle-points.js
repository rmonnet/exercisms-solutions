
export function saddlePoints(matrix) {
  
  // Compute the max of each row for later reference.
  const rowMax = matrix.map(row => Math.max(...row));

  // Compute the min of each column for later reference.
  const colMin = matrix[0].map((val, c) => Math.min(...matrix.map(row => row[c])));

  // Now check each cell in the matrix against the max of its row and the min of its column.
  const result = [];
  matrix.forEach((row, r) => {
    row.forEach((val, c) => {
      if (val == rowMax[r] && val == colMin[c]) result.push({row: r+1, column: c+1});
    })
  });
  return result;
};
