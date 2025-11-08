
export function count(diagram) {

    if (diagram.length == 0) return 0;
  
  // A Rectangle must have 2 corners on an horizontal line.
  // The other 2 corners must be on an horizontal line below the first one with
  // the corners in the same columns as the first 2 corners.
  // Also, the horizontal lines between corners must be '-' or '+'
  // and the vertical lines between corners must be '|' or '+'.
  
  const isCorner = (r, c) => diagram[r].charAt(c) == '+';
  
  const isHorizontalLine = (r, c0, c1) => {
    for (let c = c0+1; c < c1; c++) {
      const cell = diagram[r].charAt(c);
      if (cell != '-' && cell != '+') return false;
    }
    return true;
  }
  
  const isVerticalLine = (c, r0, r1) => {
    for (let r = r0+1; r < r1; r++) {
      const cell = diagram[r].charAt(c);
      if (cell != '|' && cell != '+') return false;
    }
    return true;
  }
  
  let numRect = 0;
  const numRows = diagram.length;
  const numCols = diagram[0].length;

  for (let r0 = 0; r0 < numRows; r0++) {
    for (let c0 = 0; c0 < numCols; c0++) {
      if (isCorner(r0, c0)) {
        // Find other corner to the right on the same line.
        for (let c1 = c0+1; c1 < numCols; c1++) {
          if (isCorner(r0, c1) && isHorizontalLine(r0, c0, c1)) {
            // Find other corners on the lines below.
            for (let r1 = r0+1; r1 < numRows; r1++) {
              if (isCorner(r1, c0) && isCorner(r1, c1)) {
                // Check we have proper horizontal lines and vertical lines.
                if (isHorizontalLine(r1, c0, c1) && isVerticalLine(c0, r0, r1)
                     && isVerticalLine(c1, r0, r1)) numRect++;
              }
            }
          }
        }
      }
    }
  }
  return numRect;
}
