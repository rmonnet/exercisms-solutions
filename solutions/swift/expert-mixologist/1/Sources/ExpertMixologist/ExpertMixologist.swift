func timeToPrepare(drinks: [String]) -> Double {
  var total = 0.0
  for drink in drinks {
    switch drink {
      case "beer", "soda", "water":
        total += 0.5
      case "shot":
        total += 1.0
      case "mixed drink":
        total += 1.5
      case "fancy drink":
        total += 2.5
      case "frozen drink":
        total += 3.0
      default:
        total += 0.0
    }
  }
  return total
}

func makeWedges(needed: Int, limes: [String]) -> Int {

  func numberWedges(_ lime: String) -> Int {
    switch lime {
      case "small":
        return 6
      case "medium":
        return 8
      case "large":
        return 10
      default:
        return 0
    }
  }

  var total = 0
  var needed = needed
  for lime in limes {
    if needed <= 0 { break }
    total += 1
    needed -= numberWedges(lime)
  }
  return total
}

func finishShift(minutesLeft: Int, remainingOrders: [[String]]) -> [[String]] {
  var minutesLeft = Double(minutesLeft)
  var remainingOrders = remainingOrders
  while minutesLeft > 0 && !remainingOrders.isEmpty {
    let order = remainingOrders.remove(at: 0)
    minutesLeft -= timeToPrepare(drinks: order)
  }
  return remainingOrders
}

func orderTracker(orders: [(drink: String, time: String)]) -> (
  beer: (first: String, last: String, total: Int)?, soda: (first: String, last: String, total: Int)?
) {
  var beer: (first: String, last: String, total: Int)?
  var soda: (first: String, last: String, total: Int)?
  for (drink, time) in orders {
    if drink == "beer" {
      if beer == nil {
        beer = (first: time, last: time, total: 1)
      } else {
         beer!.last = time
         beer!.total += 1
      }
    } else if drink == "soda" {
      if soda == nil {
        soda = (first: time, last: time, total: 1)
      } else {
        soda!.last = time
        soda!.total += 1
      }
    }
  }
  return (beer: beer, soda: soda)
}
