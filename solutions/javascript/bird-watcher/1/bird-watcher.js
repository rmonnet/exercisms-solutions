// @ts-check

/**
 * Calculates the total bird count.
 *
 * @param {number[]} birdsPerDay
 * @returns {number} total bird count
 */
export function totalBirdCount(birdsPerDay) {
  let total = 0;
  for (const numBirds of birdsPerDay) total += numBirds;
  return total;
}

/**
 * Calculates the total number of birds seen in a specific week.
 *
 * @param {number[]} birdsPerDay
 * @param {number} week
 * @returns {number} birds counted in the given week
 */
export function birdsInWeek(birdsPerDay, week) {
  // weeks are indexed starting at 1
  const firstIndexForWeek = (week - 1) * 7;
  let total = 0;
  for (let i = 0; i < 7; i++) {
    total += birdsPerDay[firstIndexForWeek + i];
  }
  return total;
}

/**
 * Fixes the counting mistake by increasing the bird count
 * by one for every second day.
 *
 * @param {number[]} birdsPerDay
 * @returns {number[]} corrected bird count data
 */
export function fixBirdCountLog(birdsPerDay) {
  // Fixing every second days from the first day
  for (let i = 0; i < birdsPerDay.length; i+=2) {
    birdsPerDay[i]++;
  }
  return birdsPerDay;
}
