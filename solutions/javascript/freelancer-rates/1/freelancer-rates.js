// @ts-check

const HOURS_PER_DAY = 8;
const WORKDAYS_PER_MONTH = 22;

/**
 * The day rate, given a rate per hour
 *
 * @param {number} ratePerHour
 * @returns {number} the rate per day
 */
export function dayRate(ratePerHour) {
  return ratePerHour * HOURS_PER_DAY;
}
/**
 * Calculates the number of days in a budget, rounded down
 *
 * @param {number} budget: the total budget
 * @param {number} ratePerHour: the rate per hour
 * @returns {number} the number of days
 */
export function daysInBudget(budget, ratePerHour) {
  const ratePerDay = dayRate(ratePerHour);
  return Math.floor(budget / ratePerDay);
}

/**
 * Calculates the discounted rate for large projects, rounded up
 *
 * @param {number} ratePerHour
 * @param {number} numDays: number of days the project spans
 * @param {number} discount: for example 20% written as 0.2
 * @returns {number} the rounded up discounted rate
 */
export function priceWithMonthlyDiscount(ratePerHour, numDays, discount) {
  const numMonths = Math.floor(numDays / WORKDAYS_PER_MONTH);
  const remainingDays = numDays - numMonths * WORKDAYS_PER_MONTH;
  const ratePerDay = dayRate(ratePerHour);
  const ratePerMonth = WORKDAYS_PER_MONTH * ratePerDay * (1.0 - discount);
  return Math.ceil(numMonths * ratePerMonth + remainingDays * ratePerDay);
}
