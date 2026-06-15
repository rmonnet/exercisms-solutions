func getName(_ item: (name: String, amount: Int)) -> String {
  return item.name
}

func createToy(name: String, amount: Int) -> (name: String, amount: Int) {
  return (name, amount)
}

func updateQuantity(_ items: [(name: String, amount: Int)], toy: String, amount: Int) ->  [(name: String, amount: Int)] {
  var updatedItems = items
  for (i, item) in items.enumerated() {
    if item.name == toy {
      updatedItems[i] = (toy, amount)
      break
    }
  }
  return updatedItems
}

func addCategory(_ items: [(name: String, amount: Int)], category: String) -> [(name: String, amount: Int, category: String)] {
  var updatedItems = [(name: String, amount: Int, category: String)]()
  for item in items {
    updatedItems.append((name: item.name, amount: item.amount, category: category))
  }
  return updatedItems
}
