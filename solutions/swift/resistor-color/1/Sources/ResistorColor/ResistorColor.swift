import Foundation

enum ResistorColorError: Error {
    case invalidColor(String)
}

enum ResistorColor: String, CaseIterable {
    case black
    case brown
    case red
    case orange
    case yellow
    case green
    case blue
    case violet
    case grey
    case white

    static var colors: [String] {

        ResistorColor.allCases.map { $0.rawValue }
    }

    static func colorCode(for name: String) throws -> Int {
        guard let color = ResistorColor(rawValue: name) else {
            throw ResistorColorError.invalidColor("Not a valid resistor color")
        }
        return ResistorColor.allCases.firstIndex(of: color)!
    }
}
