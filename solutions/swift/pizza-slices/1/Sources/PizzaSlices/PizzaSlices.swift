func sliceSize(diameter: Double?, slices: Int?) -> Double? {
  guard let d = diameter else { return nil }
  guard let n = slices else { return nil }
  if d < 0 { return nil }
  if n < 1 { return nil }
  return Double.pi * d*d / 4 / Double(n)
}

func biggestSlice(
  diameterA: String, slicesA: String,
  diameterB: String, slicesB: String
) -> String {
  let sizeA = sliceSize(diameter: Double(diameterA), slices: Int(slicesA))
  let sizeB = sliceSize(diameter: Double(diameterB), slices: Int(slicesB))
  switch (sizeA, sizeB) {
    case (let a?, let b?):
      if a > b {
        return "Slice A is bigger"
      } else if b > a {
        return "Slice B is bigger"
      } else {
        return "Neither slice is bigger"
      }
    case (let a?, nil):
      return "Slice A is bigger"
    case (nil, let b?):
      return "Slice B is bigger"
    case (nil, nil):
      return "Neither slice is bigger"
  }
}
