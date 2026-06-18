import Foundation

enum ResistorColorError: Error {
    case invalidColor(String)
}

enum ResistorColor: Int {
    case black = 0
    case brown = 1
    case red = 2
    case orange = 3
    case yellow = 4
    case green = 5
    case blue = 6
    case violet = 7
    case grey = 8
    case white = 9

    static let colors: [String] = [
        "black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white",
    ]

    static func colorCode(for name: String) throws -> Int {
        guard let color = ResistorColor.colors.firstIndex(of: name) else {
            throw ResistorColorError.invalidColor("Not a valid resistor color")
        }
        return color
    }
}
