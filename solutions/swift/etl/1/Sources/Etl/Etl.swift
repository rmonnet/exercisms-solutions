class ETL {
  static func transform(_ old: [String: [String]]) -> [String: Int] {
    var new = [String: Int]()
    for (pointsAsStr, letters) in old {
      guard let points = Int(pointsAsStr) else {
        fatalError("Not a valid integer")
      }
      for letter in letters {
        new[letter.lowercased()] = points
      }
    }
    return new
  }
}
