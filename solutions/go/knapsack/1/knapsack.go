package knapsack

type Item struct {
	Weight, Value int
}

// Knapsack takes in a maximum carrying capacity and a collection of items
// and returns the maximum value that can be carried by the knapsack
// given that the knapsack can only carry a maximum weight given by maximumWeight
func Knapsack(maxWeight int, items []Item) int {
	return knapsack(maxWeight, items, map[index]int{})
}

type index struct {
	nElems    int
	maxWeight int
}

func knapsack(maxWeigth int, items []Item, mem map[index]int) int {
	if maxWeigth == 0 || len(items) == 0 {
		return 0
	}
	if sol, ok := mem[index{len(items), maxWeigth}]; ok {
		return sol
	}
	lastItem := items[len(items)-1]
	var sol int
	if lastItem.Weight <= maxWeigth {
		sol = max(
			lastItem.Value+knapsack(maxWeigth-lastItem.Weight, items[:len(items)-1], mem),
			knapsack(maxWeigth, items[:len(items)-1], mem))
	} else {
		sol = knapsack(maxWeigth, items[:len(items)-1], mem)
	}
	mem[index{len(items), maxWeigth}] = sol
	return sol

}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
