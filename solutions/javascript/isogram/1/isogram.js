
export function isIsogram(word) {
  
  // Retrieve the letters from the word and count them (case insensitive).
  // If any count is greater than one, then it is not an isogram.
  let letters = word.toLowerCase().match(/[a-z]/g);
  if (!letters) return true;
  
  const frequencies = new Map();
  for (const letter of letters) {
    frequencies.set(letter, 1 + (frequencies.get(letter) || 0));
  }
  
  for (const count of frequencies.values()) {
    if (count > 1) return false;
  }
  return true;
};
