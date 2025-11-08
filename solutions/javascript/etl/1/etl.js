
export function transform(oldFormat) {
  const newFormat = {};
  for (const score in oldFormat) {
    for (const letter of oldFormat[score]) {
      newFormat[letter.toLowerCase()] = Number.parseInt(score);
    }
  }
  return newFormat;
};
