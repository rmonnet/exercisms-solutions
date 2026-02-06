package perfect_numbers

Classification :: enum {
	Perfect,
	Abundant,
	Deficient,
	Undefined,
}

classify :: proc(number: uint) -> Classification {

    if number < 1 { return .Undefined }
    sum := aliquot_sum(number)
    cl : Classification
    switch  {
    case sum < number: cl = .Deficient
    case sum == number: cl = .Perfect
    case sum > number: cl = .Abundant
    }
    return cl
}

aliquot_sum :: proc(n : uint) -> uint {

    sum : uint = 0
    for i in 1..<n {
        if n % i == 0 {
            sum += i
        }
    }
    return sum
}