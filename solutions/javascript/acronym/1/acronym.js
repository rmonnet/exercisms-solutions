
export function parse(sentence) {
  
  let words = sentence.toUpperCase().split(/[ _-]+/);
  return words.map(w => w.charAt(0)).join('');
};
