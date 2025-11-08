package variablelengthquantity

import (
    "errors"
)

const (
    mask = 0b1111111
    shift = 7
    topBit = 0b10000000
)

func encode(input uint32) []byte {
    res := [5]byte{}
    idx := 4
    last := true
    for {
        segment := byte(input & mask)
        if last {
            last = false
        } else {
            segment = segment | topBit
        }
        res[idx] = segment
        idx--
        input = input >> shift
        if input == 0 {
            break
        }
    }
    return res[idx+1:]
}

func decode(input []byte) uint32 {
    var res uint32
    for _, segment := range input {
        res = (res << shift) | uint32(segment & mask)
    }
    return res
}

func EncodeVarint(input []uint32) []byte {
    res := []byte{}
    for _, number := range input {
        res = append(res, encode(number)...)
    }
    return res
}

func DecodeVarint(input []byte) ([]uint32, error) {
    res := []uint32{}
    startIdx := 0
    endIdx := 1
    for i, codedNum := range input {
        if codedNum & topBit == 0 {
            res = append(res, decode(input[startIdx:endIdx]))
            startIdx = i + 1
            endIdx = startIdx + 1
        } else {
            endIdx++
        }
    }
    if startIdx != len(input) {
        return []uint32{}, errors.New("last byte missing from input")
    }
    return res, nil
}
