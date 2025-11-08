package bookstore

import (
	"slices"
)

const seriesSize = 5

var discounts = [seriesSize]int{0, 5, 10, 20, 25}

var groupCosts [seriesSize]int

func init() {
	for i := 0; i < seriesSize; i++ {
		groupCosts[i] = 800 * (i + 1) * (100 - discounts[i]) / 100
	}
}

type order [seriesSize]int

func NewOrder(books []int) order {
	res := order{}
	for _, book := range books {
		res[book-1] += 1
	}
	slices.Sort(res[:])
	return res
}

func (s order) findBestGrouping(upToGroupSize int) grouping {
	counts := grouping{}
	taken := 0
	for i := seriesSize - upToGroupSize; i < seriesSize; i++ {
		if s[i] > taken {
			counts[seriesSize-1-i] = s[i] - taken
			taken = s[i]
		}
	}
	return counts
}

func (s order) removeGroup(groupSize, n int) order {
	for i := seriesSize - groupSize; i < seriesSize; i++ {
		s[i] -= n
	}
	return s
}

func (s order) combineGroups(downToBookSize int) order {
	sum := 0
	for i := 0; i < seriesSize-downToBookSize; i++ {
		sum += s[i]
		s[i] = 0
	}
	s[seriesSize-downToBookSize] += sum
	return s
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func (s order) findAllGrouping() []grouping {
	res := []grouping{}
	bestGrouping := s.findBestGrouping(seriesSize)
	largestGroup := bestGrouping.largestGroupSize()
	res = append(res, bestGrouping)
	for largestGroup > 1 {
		for i := 0; i <= bestGrouping[largestGroup-1]; i++ {
			remOrder := s.removeGroup(largestGroup, i).combineGroups(largestGroup - 1)
			newGrouping := remOrder.findBestGrouping(largestGroup - 1)
			newGrouping[largestGroup-1] += i
			res = append(res, newGrouping)
		}
		largestGroup--
	}
	return res
}

type grouping [seriesSize]int

func (g grouping) largestGroupSize() int {
	for i := seriesSize - 1; i > 0; i-- {
		if g[i] != 0 {
			return i + 1
		}
	}
	return g[0]
}

func (g grouping) cost() int {
	total := 0
	for i := 0; i < seriesSize; i++ {
		total += groupCosts[i] * g[i]
	}
	return total
}

func Cost(books []int) int {
	order := NewOrder(books)
	allGroups := order.findAllGrouping()
	bestPrice := allGroups[0].cost()
	for i := 0; i < len(allGroups); i++ {
		bestPrice = min(bestPrice, allGroups[i].cost())
	}
	return bestPrice
}
