// @ts-check

/**
 * Determines how long it takes to prepare a certain juice.
 *
 * @param {string} name
 * @returns {number} time in minutes
 */
export function timeToMixJuice(name) {
  switch (name) {
    case 'Pure Strawberry Joy':
      return 0.5;
    case 'Energizer' :
      return 1.5;
    case 'Green Garden':
      return 1.5;
    case 'Tropical Island':
      return 3.0;
    case 'All or Nothing':
      return 5.0;
    default:
      return 2.5;
  }
}

/**
 * Computes the number of wedges available for a given lime size.
 */
function numberOfWedges(limeSize) {
  switch (limeSize) {
    case 'small':
      return 6;
    case 'medium':
      return 8;
    case 'large':
      return 10;
    default:
      return 0;
  }
}

/**
 * Calculates the number of limes that need to be cut
 * to reach a certain supply.
 *
 * @param {number} wedgesNeeded
 * @param {string[]} limes
 * @returns {number} number of limes cut
 */
export function limesToCut(wedgesNeeded, limes) {
  let totalWedges = 0;
  let numberLimes = 0;
  while (totalWedges < wedgesNeeded && numberLimes < limes.length) {
    numberLimes++;
    totalWedges += numberOfWedges(limes[numberLimes-1]);
  }
  return numberLimes;
}

/**
 * Determines which juices still need to be prepared after the end of the shift.
 *
 * @param {number} timeLeft
 * @param {string[]} orders
 * @returns {string[]} remaining orders after the time is up
 */
export function remainingOrders(timeLeft, orders) {
  while (orders.length > 0 && timeLeft > 0) {
    const nextOrder = orders.shift();
    timeLeft -= timeToMixJuice(nextOrder);;
  }
  return orders;
}
