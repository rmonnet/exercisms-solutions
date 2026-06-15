func remainingMinutesInOven(elapsedMinutes: Int, expectedMinutesInOven: Int = 40) -> Int {
  return expectedMinutesInOven - elapsedMinutes
}

func preparationTimeInMinutes(layers: String...) -> Int {
  return 2 * layers.count
}

func quantities(layers: String...) -> (noodles: Int, sauce: Double) {
  var noodles = 0
  var sauce = 0.0
  for layer in layers {
    if layer == "noodles" {
        noodles += 3
    } else if layer == "sauce" {
        sauce += 0.2
    }
  }
  return (noodles, sauce)
}

func toOz(_ amount: inout (noodles: Int, sauce: Double)) {
  amount.sauce *= 33.814
}

func redWine(layers: String...) -> Bool {

  func layerCount(_ layers: [String], _ type: String) -> Int {
    var total = 0
    for layer in layers {
      if layer == type {
        total += 1
      }
    }
    return total
  }

  let mozzarella = layerCount(layers, "mozzarella")
  let ricotta = layerCount(layers, "ricotta")
  let bechamel = layerCount(layers, "béchamel")
  let sauce = layerCount(layers, "sauce")
  let meat = layerCount(layers, "meat")
  return meat + sauce >= mozzarella + ricotta + bechamel
}
