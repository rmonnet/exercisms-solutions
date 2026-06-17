func toLimit(_ limit: Int, inMultiples: [Int]) -> Int {
  var multiples = Set<Int>()
  for item in inMultiples {
    if item == 0 { continue }
    var multiple = item
    while multiple < limit {
      multiples.insert(multiple)
      multiple += item
    }
  }
  var total = 0
  for multiple in multiples {
    total += multiple
  }
  return total
}
