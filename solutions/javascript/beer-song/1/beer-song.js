
export function recite(initialBottlesCount, takeDownCount) {

  // Decides if we need to print 'no more bottles', '1 bottle', or 'N bottles'.
  const bottle = (n) => 
    n == 0 ? 'no more bottles' 
    : n == 1 ? '1 bottle'
    : `${n} bottles`

  // Decide if we need to print 'Take it' or 'Take one'
  const take = (n) => n == 0 ? 'Take it' : 'Take one'

  let result = []
  
  for (let i = 0; i < takeDownCount; i++) {
  
    if (i > 0) result.push('')
    
    let count = initialBottlesCount - i
    
    if (count == 0) {
      result.push('No more bottles of beer on the wall, no more bottles of beer.')
      result.push('Go to the store and buy some more, 99 bottles of beer on the wall.')
      break
    }
    
    result.push(
      `${bottle(count)} of beer on the wall, ${bottle(count)} of beer.`)
    count--
    result.push(`${take(count)} down and pass it around, ${bottle(count)} of beer on the wall.`)
  }
  
  return result

};
