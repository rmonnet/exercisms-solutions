import Foundation

func gigasecond(from: Date) -> Date {
  var to = from
  to.addTimeInterval(1_000_000_000)
  return to
}
