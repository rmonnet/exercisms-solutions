// @ts-check

/**
 * Determine how many cards of a certain type there are in the deck
 *
 * @param {number[]} stack
 * @param {number} card
 *
 * @returns {number} number of cards of a single type there are in the deck
 */
export function cardTypeCheck(stack, card) {
 
  let numberCards = 0;
  stack.forEach(value => {if (value == card) numberCards++});
  return numberCards;
}

/**
 * Determine how many cards are odd or even
 *
 * @param {number[]} stack
 * @param {boolean} type the type of value to check for - odd or even
 * @returns {number} number of cards that are either odd or even (depending on `type`)
 */
export function determineOddEvenCards(stack, typeIsEven) {

  const reminder = typeIsEven ? 0 : 1;
  let numberCards = 0;
  for (const value of stack) {
    if (value % 2 == reminder) numberCards++;
  }
  return numberCards;
}
