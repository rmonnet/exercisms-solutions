func newScoreBoard() -> [String: Int] {
  return [String: Int]()
}

func addPlayer(_ scores: inout [String: Int], _ name: String, _ score: Int = 0) {
  scores[name] = score
}

func removePlayer(_ scores: inout [String: Int], _ name: String) {
  scores.removeValue(forKey: name)
}

func resetScore(_ scores: inout [String: Int], _ name: String) {
  if scores[name] == nil { return }
  scores[name] = 0
}

func updateScore(_ scores: inout [String: Int], _ name: String, _ delta: Int) {
  if scores[name] == nil { return }
  scores[name] = scores[name, default: 0] + delta
}

func orderByPlayers(_ scores: [String: Int]) -> [(String, Int)] {

  func compare(left: (String, Int), right: (String, Int)) -> Bool {
    return left.0 < right.0
  }
  
  var players = [(String, Int)]()
  for (name, score) in scores {
    players.append((name, score))
  }
  return players.sorted(by: compare)
}

func orderByScores(_ scores: [String: Int]) -> [(String, Int)] {
  
  func compare(left: (String, Int), right: (String, Int)) -> Bool {
    return left.1 > right.1
  }
  
  var players = [(String, Int)]()
  for (name, score) in scores {
    players.append((name, score))
  }
  return players.sorted(by: compare)
}
