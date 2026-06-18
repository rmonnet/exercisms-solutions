func isArmstrongNumber(_ number: Int) -> Bool {
    let digits = toReversedDigits(number)
    let sum = digits.reduce(0) { (acc, digit) in acc + pow(digit, to: digits.count) }
    return number == sum
}

// Note: this returns the digits in reverse order but it doesn't matter
// when checking if a number is an armstorng number
func toReversedDigits(_ number: Int) -> [Int] {
    var digits = [Int]()
    var remaining = number
    while remaining > 0 {
        digits.append(remaining % 10)
        remaining /= 10
    }
    return digits
}

func pow(_ n: Int, to: Int) -> Int {
    return (1...to).reduce(1) { acc, _ in acc * n }
}
