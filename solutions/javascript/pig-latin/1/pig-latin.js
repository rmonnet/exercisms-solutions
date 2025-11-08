
// We will use regular expressions to match the rules and break down the words in the relevant pieces.
// More general rules (like rule2) will be placed lower to let the more specific rules match first.

function translateWord(word) {

  const rule1 = word.match(/^([aeiou]|xr|yt).*$/)
  if (rule1) return `${rule1[0]}ay`;

  const rule3 = word.match(/^([^aeiou]?)qu(.*)$/);
  if (rule3) return `${rule3[2]}${rule3[1]}quay`;

  const rule4 = word.match(/^([^aeiou]+)y(.*)$/);
  if (rule4) return `y${rule4[2]}${rule4[1]}ay`;

  const rule2 = word.match(/^([^aeiou]+)(.*)$/)
  if (rule2) return `${rule2[2]}${rule2[1]}ay`;

  return word;

};

export function translate(sentence) {
  return sentence.split(' ').map(w => translateWord(w)).join(' ');
}