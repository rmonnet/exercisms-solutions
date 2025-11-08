
// We generate all the names up front and then just randomly pick one.
// This is faster than randomly picking and assembling 2 letters and 3 digits
// and avoid timing out in the test 'all the names can be generated'.

const LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
const DIGITS = '0123456789'.split('');

const ALL_NAMES = function() {
  const names = new Array(2*LETTERS.length+3*DIGITS.length);
  let idx = 0;
  for (const l1 of LETTERS)
    for (const l2 of LETTERS)
      for (const d1 of DIGITS)
        for (const d2 of DIGITS)
          for (const d3 of DIGITS)
            names[idx++] = l1 + l2 + d1 + d2 + d3;
  return names;
}()

const TOTAL_NAMES = ALL_NAMES.length;

// The Robot class defines robots with unique names.
export class Robot {

  // The NAMES fields keep track of the robot names in used so we can ensure they are unique.
  static NAMES = new Set();

  // Releases the names in used so we can start from scratch.
  static releaseNames() {
    Robot.NAMES.clear();
  }

  // Create a new unique name, the name will not be reused until Robot.releaseNames() is called.
  static _newName() {
    // keep going until we get a unique name
    while (true) {
      let name = ALL_NAMES[Math.floor(Math.random() * TOTAL_NAMES)];
      if (!Robot.NAMES.has(name)) {
        Robot.NAMES.add(name);
        return name;
      }
    }
  }

  // Constructs a new robot with a unique name.
  constructor() {
   this._name = Robot._newName();
  }

  // Reset the robot name to a new, unused name.
  reset() {
    this._name = Robot._newName();
  }

  // Return the name of the robot (read-only property).
  get name() {
    return this._name;
  }

  
}
