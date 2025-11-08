package bottlesong

import (
    "fmt"
)

var nums = []string{"no", "one", "two", "three", "four", "five", "six",
                      "seven", "eight", "nine", "ten"}

var capNums = []string{"No", "One", "Two", "Three", "Four", "Five", "Six",
                      "Seven", "Eight", "Nine", "Ten"}

func plural(n int) string {
    // We only use "bottle" (singular) for one (not "no bottles").
    switch n {
        case 1: return ""
        default: return "s"
    }
}

func Recite(startBottles, takeDown int) []string {
    res := []string{}
    for i := 0; i < takeDown; i++ {
        n := startBottles - i
        // Need an empty line to separate paragraphs.
        if i > 0 {
            res = append(res, "")
        }
		verse1 := fmt.Sprintf("%s green bottle%s hanging on the wall,", 
                                  capNums[n], plural(n))
        verse3 := "And if one green bottle should accidentally fall,"
        verse4 := fmt.Sprintf("There'll be %s green bottle%s hanging on the wall.",
                                   nums[n-1], plural(n-1))
        res = append(res, verse1, verse1, verse3, verse4)    
    }
    return res
}
