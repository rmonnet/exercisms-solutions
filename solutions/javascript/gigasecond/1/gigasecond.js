
const GIGASECOND_IN_MS = 1.0e9 * 1000;

export function gigasecond(date) {
  return new Date(date.getTime() + GIGASECOND_IN_MS);
}

