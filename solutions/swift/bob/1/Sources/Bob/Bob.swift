import Foundation

class Bob {
  static func response(_ message: String) -> String {

    let trimmedMessage = message.trimmingCharacters(in: .whitespacesAndNewlines)
    if allCaps(trimmedMessage) {
      if trimmedMessage.hasSuffix("?") {
        return "Calm down, I know what I'm doing!"
      } else {
        return "Whoa, chill out!"
      }
    } else if trimmedMessage.hasSuffix("?") {
      return "Sure."
    } else if trimmedMessage == "" {
      return "Fine. Be that way!"
    } else {
      return "Whatever."
    }
  }
}

func allCaps(_ message: String) -> Bool {
  return message.rangeOfCharacter(from: .letters) != nil && message == message.uppercased()
}
