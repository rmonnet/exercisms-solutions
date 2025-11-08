
export function proverb(...words) {

  const qualifier = (typeof words[words.length-1] == 'object') ? `${words.pop().qualifier} ` : '';
  if (words.length == 0) return '';
  
  let proverb = '';
  let previousWord = words[0];
  for (const word of words.slice(1)) {
    proverb += `For want of a ${previousWord} the ${word} was lost.\n`;
    previousWord = word;
  }
  proverb += `And all for the want of a ${qualifier}${words[0]}.`;
  return proverb;
};
