
export function findAnagrams(word, candidates) {

  // A function to compute the content of a word as a set of sorted, case insensitive characters.
  const content = (word) => word.toLowerCase().split('').sort().join('');
  
  let wordContent = content(word);
  let lcWord = word.toLowerCase();
  
  return candidates.filter(c => (content(c) == wordContent) && (lcWord != c.toLowerCase()));
};
