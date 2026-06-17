func reverseString(_ input: String) -> String {
    // Note: on purpose don't use the built-in String.reversed().
    var chars = Array(input)
    let len = chars.count
    for i in 0..<(len / 2) {
        chars.swapAt(i, len - i - 1)
    }
    return String(chars)
}
