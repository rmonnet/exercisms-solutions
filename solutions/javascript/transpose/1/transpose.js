
export function transpose(strings) {
  
  if (strings.length == 0) return [];
  
  // To transpose a matrix, it needs to be rectangular (i.e. all rows must be of
  // the same length).
  // If all the lines in the original matrix are not of the same length, then we will
  // right pad the shorter lines with spaces.
  // There is an exception: If the set of last original lines are shorter, don't pad them.
  const maxLength = strings.reduce((max, string) => Math.max(string.length, max), 0);

  let result = [];
  for (let c = 0; c < maxLength; c++) {
    const rowCharacters = [];
    for (let i = 0; i < strings.length; i++) {
      rowCharacters.push(strings[i].charAt(c) || ' ');
    }
    let row = rowCharacters.join('');
    // clean up trailing blanks on the last row
    if (c == maxLength-1) row = row.trimRight();
    result.push(row);
  }
  return result;
};
