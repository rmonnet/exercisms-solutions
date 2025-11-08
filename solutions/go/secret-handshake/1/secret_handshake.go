package secret

import "slices"

const (
    wink = 1 << iota
    doubleBlink
    closeYourEyes
    jump
    reverse
)


func Handshake(code uint) []string {
	res := []string{}
    if code & wink != 0 {
        res = append(res, "wink")
    }
    if code & doubleBlink != 0 {
        res = append(res, "double blink")
    }
    if code & closeYourEyes != 0 {
        res = append(res, "close your eyes")
    }
    if code & jump != 0 {
        res = append(res, "jump")
    }
    if code & reverse != 0 {
        slices.Reverse(res)
    }
    return res
}
