package yacht

import (
    "slices"
)

// Insight: it is much easier to check most of the combinations
// if the dices are sorted.

func choice(dice []int) int {
    sum := 0
    for _, draw := range dice {
        sum += draw
    }
    return sum
}

func sumOf(dice []int, value int) int {
	sum := 0
    for _, draw := range dice {
        if draw == value {
            sum += value
        }
    }
    return sum
}

func fiveOfAKind(dice []int) int {
    slices.Sort(dice)
    // valid case: XXXXX
    if dice[0] == dice[4] {
        return 50
    }
    return 0
}

func fourOfAKind(dice []int) int {
    slices.Sort(dice)
    // valid case: XXXXY
    if dice[0] == dice[3] {
        return 4 * dice[0]
    }
    // or XYYYY
    if dice[1] == dice[4] {
        return 4 * dice[1]
    }
    return 0
}

func fullHouse(dice []int) int {
    slices.Sort(dice)
    // valid case: XXYYY
    if dice[0] == dice[1] && dice[2] == dice[4] && dice[1] != dice[2] {
        return 2 * dice[0] + 3 * dice[2]
    }
    // or XXXYY
    if dice[0] == dice[2] && dice[3] == dice[4] && dice[2] != dice[3] {
        return 3 * dice[0] + 2 * dice[3]
    }
    return 0
}

func littleStraight(dice[] int) int {
    slices.Sort(dice)
    if dice[0] == 1 && dice[1] == 2 && dice[2] == 3 &&
    	dice[3] == 4 && dice[4] == 5 {
    	return 30        
    }
    return 0
}

func bigStraight(dice[] int) int {
    slices.Sort(dice)
    if dice[0] == 2 && dice[1] == 3 && dice[2] == 4 &&
    	dice[3] == 5 && dice[4] == 6 {
    	return 30        
    }
    return 0
}


func Score(dice []int, category string) int {
	switch category {
        case "ones": return sumOf(dice, 1)
        case "twos": return sumOf(dice, 2)
        case "threes": return sumOf(dice, 3)
        case "fours": return sumOf(dice, 4)
        case "fives": return sumOf(dice, 5)
        case "sixes": return sumOf(dice, 6)
        case "full house": return fullHouse(dice)
        case "four of a kind": return fourOfAKind(dice)
        case "little straight": return littleStraight(dice)
        case "big straight": return bigStraight(dice)
        case "choice": return choice(dice)
        case "yacht": return fiveOfAKind(dice)
        default:
        	panic("unknown category:" + category)
    }
}
