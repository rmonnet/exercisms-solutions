

export function countWords(sentence) {
  // clean-up the sentence
  // we want to remove non-words, non-numbers, single quotes when not surrounded by letters,
  // and any other characters.
  // we also want to use a single space as separator to facilitate parsing the sentence.
  const cleanedUpSentence = sentence.toLowerCase()
    .replace(/^'/, '')                // remove single quote starting the sentence
    .replace(/'$/, '')                // remove single quote ending the sentence
    .replace(/ '/g, ' ')             // remove single quotes when starting a word
    .replace(/' /g, ' ')             // remove single quotes when ending a word
    .replace(/[^a-zA-Z0-9']/g, ' ') // remove anything but letters, numbers and remaining single quotes
    .replace(/\s+/g, ' ')           // replace multiple spaces by single spaces
    .trim();                        // remove trailing and leading spaces

  let counts = {}
  for (const word of cleanedUpSentence.split(' ')) {
    counts[word] = (counts[word] || 0) + 1;
  }
  return counts;
};
