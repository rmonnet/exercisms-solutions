typealias ChangeClosure = @Sendable ((String, String, String)) -> (String, String, String)

let flip: ChangeClosure = { tuple in (tuple.1, tuple.0, tuple.2) }

let rotate: ChangeClosure = { tuple in (tuple.1, tuple.2, tuple.0) }

func makeShuffle(
  flipper: @escaping ((String, String, String)) -> (String, String, String),
  rotator: @escaping ((String, String, String)) -> (String, String, String)
) -> ([UInt8], (String, String, String)) -> (String, String, String) {

  func shuffler(id: [UInt8], wires: (String, String, String)) -> (String, String, String) {
    var wires = wires
    for bit in id.reversed() {
      if bit == 0 {
        wires = flipper(wires)
      } else if bit == 1 {
        wires = rotator(wires)
      }
    }
    return wires
  }

  return shuffler
}
