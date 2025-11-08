
// Converts the key to the secret handshake.
// Returns an array of gesture with the handshakes.
export function commands(key) {

  // Converts to binary and reverts to always have the lowest digits
  // in the same place.
  const commands = key.toString(2).split('').reverse();
  let result = [];

  // build the set of handshakes by following the rules
  if (commands[0] === '1') result.push('wink');
  if (commands[1] === '1') result.push('double blink');
  if (commands[2] === '1') result.push('close your eyes');
  if (commands[3] === '1') result.push('jump');
  if (commands[4] === '1') result.reverse();
  
  return result;
};
