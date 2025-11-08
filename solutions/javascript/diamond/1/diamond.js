
const LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('')

export function rows(letter) {

  const rank = LETTERS.indexOf(letter)
  // The size of the diamond (heigth/width) is increasing by 2 with each letter (and starts at 1 with 'A')
  const nLines = 2 * rank + 1

  let result = []
  for (let line = 0; line < nLines; line++) {

    // The letters increase alphabetically until we get to the middle (line = rank) of the diamond.
    // They then decrease alphabetically with each line.
    const letterIndex = line <= rank ? line : (nLines - line -1)

    // Use an array of letter rather than a string, it is easier to manipulate
    // Fill it with blank and set copy the letter in two positions.
    // The first line starts with the letter at the center (rank) and then moving to each side
    // by one character (same as letter index).
    // 'A' can be seen as a special case where both 'A' are written on top of each other (at the center
    // of the line)
    let lineContent = new Array(nLines).fill(' ')
    lineContent.splice(rank-letterIndex, 1, LETTERS[letterIndex])
    lineContent.splice(rank+letterIndex, 1, LETTERS[letterIndex])
    
    result.push(lineContent.join(''))
  }
  return result
};
