// TODO: Define the Size struct
struct Size {
    var width: Int = 80
    var height: Int = 60

    mutating func resize(newWidth: Int, newHeight: Int) {
        self.width = newWidth
        self.height = newHeight
    }
}

// TODO: Define the Position struct
struct Position {
    var x: Int = 0
    var y: Int = 0

    mutating func moveTo(newX: Int, newY: Int) {
        self.x = newX
        self.y = newY
    }
}

// TODO: Define the Window class
class Window {
    var title: String = "New Window"
    let screenSize: Size = Size(width: 800, height: 600)
    var size: Size = Size()
    var position: Position = Position()
    var contents: String? = nil

    init() {}

    init(title: String, contents: String?, size: Size = Size(), position: Position = Position()) {
        self.title = title
        self.contents = contents
        self.size = size
        self.position = position
    }

    func resize(to: Size) {
        var newWidth = max(to.width, 1)
        newWidth = min(newWidth, screenSize.width - position.x)
        var newHeight = max(to.height, 1)
        newHeight = min(newHeight, screenSize.height - position.y)
        size.resize(newWidth: newWidth, newHeight: newHeight)
    }

    func move(to: Position) {
        var newX = max(to.x, 0)
        newX = min(newX, screenSize.width - size.width)
        var newY = max(to.y, 0)
        newY = min(newY, screenSize.height - size.height)
        position.moveTo(newX: newX, newY: newY)
    }

    func update(title: String) {
        self.title = title
    }

    func update(text: String?) {
        self.contents = text
    }

    func display() -> String {
        let text = self.contents ?? "[This window intentionally left blank]"
        return "\(title)\nPosition: (\(position.x), \(position.y)), Size: (\(size.width) x \(size.height))\n\(text)\n"
    }

}