
export function spiralMatrix(size) {

  const matrix = [];
  const numCells = size**2;

  // initialize the rows
  for (let i = 0; i < size; i++) {
    matrix[i] = [];
  }
  
  // setup the limits of the current spiral
  // note: iMin is 1, not 0 since, ny the time we got there we would have already populated
  // the first row.
  let iMin = 1;
  let iMax = size-1;
  let jMin = 0;
  let jMax = size-1;

  // Start at the top left, moving to the right.
  let nextI = 0;
  let nextJ = 0;
  let iInc = 0;
  let jInc= 1;
  
  for (let i = 1; i <= numCells; i++) {
    
    // Populate the current cell and move to the next.
    matrix[nextI][nextJ] = i;
    
    if (jInc == 1 && nextJ == jMax) {
      // We reached the right side, start moving down.
      iInc = 1;
      jInc = 0;
      // Shorten the next spiral.
      jMax--;
    } else if (iInc == 1 && nextI == iMax) {
      // We reached the bottom, start moving left.
      iInc = 0;
      jInc = -1;
      // Shorten the next spiral.
      iMax--;
    } else if (jInc == -1 && nextJ == jMin) {
      // We reached the left side, start moving up
      iInc = -1;
      jInc = 0;
      // Shorten the next spiral.
      jMin++;
    } else if (iInc == -1 && nextI == iMin) {
      // We reached the top, start moving right
      iInc = 0;
      jInc = 1;
      // Shorten the next spiral.
      iMin++;
    }

    // Go to the next cell.
    nextI += iInc;
    nextJ += jInc;
  }
  return matrix;
};

