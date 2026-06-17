enum LogLevel: Int {
    case trace = 0
    case debug = 1
    case info = 4
    case warning = 5
    case error = 6
    case fatal = 7
    case unknown = 42

    init(_ msg: String) {
        self =
            switch String(msg.prefix(5)) {
            case "[TRC]": .trace
            case "[DBG]": .debug
            case "[INF]": .info
            case "[WRN]": .warning
            case "[ERR]": .error
            case "[FTL]": .fatal
            default: .unknown
            }
    }

    func shortFormat(message: String) -> String {
        return "\(self.rawValue):\(message)"
    }
}
