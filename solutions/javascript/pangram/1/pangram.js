

export function isPangram(sentence) {

  // use a filter to eliminate non-letters (any other than [a-z])
  // use a set to eliminate duplicates
  
  const letters = sentence.toLowerCase().split('').filter(l => l >= 'a' && l <= 'z');
  return (new Set(letters)).size == 26;
};
