
// Computes the first n rows of the Pascal's triangle.
export function rows(n) {
  
  if (n < 1) return [];
  
  let result = [[1]];
  for (let r = 1; r < n; r++) {
    let row = [1];
    row[r] = 1;
    for (let c = 1; c < r; c++) {
      row[c] = result[r-1][c-1] + result[r-1][c];
    }
    result.push(row);
  }
  return result;
};
