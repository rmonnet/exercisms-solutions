func getCard(at index: Int, from stack: [Int]) -> Int {
  return stack[index]
}

func setCard(at index: Int, in stack: [Int], to newCard: Int) -> [Int] {
  if index < 0 || index >= stack.count {
    return stack
  }
  var result = stack
  print(result)
  result[index] = newCard
  return result
}

func insert(_ newCard: Int, atTopOf stack: [Int]) -> [Int] {
  var result = stack
  result.append(newCard)
  return result
}

func removeCard(at index: Int, from stack: [Int]) -> [Int] {
    if index < 0 || index >= stack.count {
    return stack
  }
  var result = stack
  result.remove(at: index)
  return result
}

func insert(_ newCard: Int, at index: Int, from stack: [Int]) -> [Int] {
   if index < 0 || index > stack.count {
    return stack
  }
  var result = stack
  result.insert(newCard, at: index)
  return result
}

func checkSizeOfStack(_ stack: [Int], _ size: Int) -> Bool {
  return stack.count == size
}
