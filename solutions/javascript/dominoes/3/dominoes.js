// left returns the left side of a domino.
function left(domino) {
  return domino[0]
}

// right returns the right side of a domino
function right(domino) {
  return domino[1]
}

// flip reverses the two end of a domino.
function flip(domino) {
    return [right(domino), left(domino)]
}

// letfOvers makes a copy of the list of dominoes and remove the one at the specified index.
function leftovers(dominoes, index) {
    const result = [...dominoes]
    result.splice(index, 1)
    return result
}

// buildSubchain orders a chain of dominoes so that each left side of a domino matches the 
// right side of the preceding one, the left side of the first domino
// matches the leftmost constraint, and the right side of the last one matches the
// rightmost constraint.
// It is called recursively until a solution is found or all possibilities have been exhausted.
function buildSubchain(dominoes, leftmost, rightmost) {

  // end of the chain, check that the domino match the constraints.
  if (dominoes.length == 1) {
    const domino = dominoes[0]
    if (left(domino) == leftmost && right(domino) == rightmost) return [domino]
    if (left(domino) == rightmost && right(domino) == leftmost) return [flip(domino)]
    return null
  }

  // Pick a domino from the chain and see if we can make it the rightmost of a chain.
  // Try to build a subchain with the remaining dominoes.
  for (const [i, domino] of dominoes.entries()) {

    // Try the domino.
    if (left(domino) == leftmost) {
      const newLeftmost = right(domino)
      const subchain = buildSubchain(leftovers(dominoes, i), newLeftmost, rightmost)
      if (subchain) return [domino].concat(subchain)
    }
    // It didn't work, try to flip the domino.
    if (right(domino) == leftmost) {
      const newLeftmost = left(domino)
      const subchain = buildSubchain(leftovers(dominoes, i), newLeftmost, rightmost)
      if (subchain) return [flip(domino)].concat(subchain)
    }
  }
  // None of the dominos can be used as the next one in the chain.           
  return null
}



// Orders a chain of dominoes so that each left side of a domino matches the 
// right side of the preceding one, and that the left side of the first domino
// matches the right side of the last one.
// If a solution is not possible, returns null.
// In the case where there is more than one solution, chain will return one of them.
// A domino can be flipped to make the chain.
export function chain(dominoes) {

  // Take care of the easy cases first.
  
  // If called with no dominoe then the answer is the empty chain.
  if (dominoes.length == 0) return []

  // If called with one dominoe, only succeed if the domino is a doublet.
  if (dominoes.length == 1) return (left(dominoes[0]) == right(dominoes[0])) ? dominoes : null

  // we have at least two dominoes, since we are building a chain, any of the domino can be used as
  // the starting point. Also, we have a solution, the flipped chain is also a solution so there is no
  // need to flip the first domino.
  const domino = dominoes[0]
  const [rightmost, leftmost] = domino
  const subchain = buildSubchain(leftovers(dominoes, 0), leftmost, rightmost)
  if (subchain) return [domino].concat(subchain)
  // There is no solution.
  return null
}

