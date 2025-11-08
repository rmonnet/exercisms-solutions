
export function score(dices, category) {

  // Count the number of time the 'value' appears in the 'array'.
  const numberOf = (value, array) =>  array.filter(n => n == value).length

  // Count the number of time each dice is rolled.
  // It returns an array of 7 values, so that the dice value and the array index
  // match.
  const getFrequencies = () => {
    const result = new Array(7).fill(0)
    dices.forEach(dice => result[dice]++)
    return result
  }

  // Return the sum of the values in the array.
  const sum = (array) => array.reduce((acc, val) => acc+val, 0)
  
  switch (category) {
    case 'yacht':
      if (numberOf(dices[0], dices) == 5) return 50;
      return 0;
    case 'ones':
      return numberOf(1, dices)
    case 'twos':
      return 2 * numberOf(2, dices)
    case 'threes':
      return 3 * numberOf(3, dices)
    case 'fours':
      return 4 * numberOf(4, dices)
    case 'fives':
      return 5 * numberOf(5, dices)
    case 'sixes':
      return 6 * numberOf(6, dices)
    case 'full house': {
      const frequencies = getFrequencies()
      const threeOfAKind = frequencies.indexOf(3)
      const twoOfAKind = frequencies.indexOf(2)
      if (threeOfAKind < 1 || twoOfAKind < 1) return 0
      return 3 * threeOfAKind + 2 * twoOfAKind
    }
    case 'four of a kind': {
      const frequencies = getFrequencies()
      let fourOfAKind = frequencies.indexOf(4)
      if (fourOfAKind < 1) fourOfAKind = frequencies.indexOf(5)
      if (fourOfAKind < 1) return 0
      return 4 * fourOfAKind
    }
    case 'little straight': {
      const frequencies = getFrequencies()
      if (numberOf(1, frequencies.slice(1, 6)) == 5) return 30
      return 0
    }
    case 'big straight': {
      const frequencies = getFrequencies()
      if (numberOf(1, frequencies.slice(2, 7)) == 5) return 30
      return 0
    }
    case 'choice':
      return sum(dices)
    default:
      return 0;
  }
};
