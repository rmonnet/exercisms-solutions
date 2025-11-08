// Flips the two end of a domino.
function flip(domino) {
    return [domino[1], domino[0]]
}

// Makes a copy of the list of dominoes and remove the one at the specified index.
function remove(dominoes, index) {
    const result = [...dominoes]
    result.splice(index, 1)
    return result
}

// Orders a chain of dominoes so that each left side of a domino matches the 
// right side of the preceding one, and that the left side of the first domino
// matches the right side of the last one.
// If a solution is not possible, returns null.
// In the case where there is more than one solution, chain will return one of them.
// A domino can be flipped to make the chain.
// When the function is called recursively to build a subchain, leftmost and rightmost
// provides the constraints on the sides of the subchain.
export function chain(dominoes, leftmost, rightmost) {

  // Take care of the easy cases first.
  
  // If called with no dominoe then the answer is the empty chain.
  if (dominoes.length == 0) return []

  // If called with one dominoe and it is the initial call, only succeed if the domino
  // is a doublet.
  if (leftmost == null && dominoes.length == 1) return (dominoes[0][0] == dominoes[0][1]) ? dominoes : null

  // If called with one domino but we have constraints on the leftmost and rightmost values, check that
  // the domino match them.
  if (dominoes.length == 1) {
    if (dominoes[0][0] == leftmost && dominoes[0][1] == rightmost) return dominoes
    if (dominoes[0][0] == rightmost && dominoes[0][1] == leftmost) return [flip(dominoes[0])]
    return null
  }

  // Pick a domino from the chain and see if we can make it the leftmost of a chain.
  // We will assume it is the beginning of the chain and see if we can build a chain with
  // the remaining dominos that goes to the right of the one we picked.
  // If leftmost/rightmost are set, we alreayd have constraints on the chain right-most and left-most values,
  // only dominoes that match one of these contraints can be used as the next brick.
  for (const [i, domino] of dominoes.entries()) {

    if (leftmost == null || domino[0] == leftmost) {
      const subchain = chain(remove(dominoes, i), domino[1], (rightmost != null) ? rightmost : domino[0])
      if (subchain) return [domino].concat(subchain)
    }
    if (leftmost == null || domino[1] == leftmost) {
      const subchain = chain(remove(dominoes, i), domino[0], (rightmost != null) ? rightmost : domino[1])
      if (subchain) return [flip(domino)].concat(subchain)
    }
  }
                   
  return null
};

