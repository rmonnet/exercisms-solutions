//
// This is only a SKELETON file for the 'Resistor Color Duo' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export function decodedValue(bands) {
  return 10 * colorValue(bands[0]) + colorValue(bands[1]);
}

function colorValue(color) {
  return COLORS.indexOf(color);
}

const COLORS = ['black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue',
    'violet', 'grey', 'white'];

