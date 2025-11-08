package change

import (
	"errors"
)

func minCoins(coins []int, target int, mem map[int][]int) ([]int, bool) {
	if target == 0 {
		return []int{}, true
	}
	if existingSol, ok := mem[target]; ok {
		return existingSol, true
	}
	var bestSol []int
	for _, coin := range coins {
		if coin <= target {
			if subSol, ok := minCoins(coins, target-coin, mem); ok {
				if len(subSol)+1 < len(bestSol) || bestSol == nil {
					bestSol = append([]int{coin}, subSol...)
				}
			}
		}
	}
	if bestSol == nil {
		return []int{}, false
	}
	mem[target] = bestSol
	return bestSol, true
}

func Change(coins []int, target int) ([]int, error) {
	if target == 0 {
		return []int{}, nil
	}
	if target < coins[0] {
		return []int{}, errors.New("all coins are larger than requested change")
	}
	sol, ok := minCoins(coins, target, map[int][]int{})
	if !ok {
		return []int{}, errors.New("no solution exists")
	}
	return sol, nil
}
