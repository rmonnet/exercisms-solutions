func totalBirdCount(_ birdsPerDay: [Int]) -> Int {
  var total = 0
  for dayTotal in birdsPerDay {
    total += dayTotal
  }
  return total
}

func birdsInWeek(_ birdsPerDay: [Int], weekNumber: Int) -> Int {
  let firstIndex = (weekNumber - 1) * 7
  var total = 0
  for i in firstIndex..<(firstIndex+7) {
    total += birdsPerDay[i]
  }
  return total
}

func fixBirdCountLog(_ birdsPerDay: [Int]) -> [Int] {
  var correctedStats = birdsPerDay
  for i in 0..<correctedStats.count {
    if i % 2 == 0 {
      correctedStats[i] += 1
    }
  }
  return correctedStats
}
