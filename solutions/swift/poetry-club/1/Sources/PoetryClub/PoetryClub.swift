import Foundation

func splitOnNewlines(_ poem: String) -> [String] {
  return poem.components(separatedBy: "\n")
}

func frontDoorPassword(_ phrase: String) -> String {
  var letters = [String]()
  for sentence in splitOnNewlines(phrase) {
    if let first = sentence.first {
      letters.append(String(first))
    } else {
      letters.append("_")
    }
  }
  return letters.joined()
}
  

func backDoorPassword(_ phrase: String) -> String {
  var letters = [String]()
  for sentence in splitOnNewlines(phrase) {
    let trimmedSentence = sentence.trimmingCharacters(in: .whitespaces)
    if let last = trimmedSentence.last {
      letters.append(String(last))
    } else {
      letters.append("_")
    }
  }
  return "\(letters.joined()), please"
}

func secretRoomPassword(_ phrase: String) -> String {
  var letters = [String]()
  for (i, sentence) in splitOnNewlines(phrase).enumerated() {
    let index = sentence.index(sentence.startIndex, offsetBy: i, limitedBy: sentence.endIndex)
    if let validIndex = index {
      letters.append(String(sentence[validIndex]))
    } else {
      letters.append("_")
    }
  }
  return "\(letters.joined().uppercased())!"
}
