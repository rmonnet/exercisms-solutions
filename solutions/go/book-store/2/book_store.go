package bookstore

import (
	"slices"
)

// SeriesSize represents the number of books in the series.
// The algorithm below is general so this could be change to a different size
// as long as the input and discounts are adjusted.
const seriesSize = 5

// Discounts represents the discount for each group size
// (i.e. size of the set of independent books purchased).
// Group of size 1 is associated with index 0.
var discounts = [seriesSize]int{0, 5, 10, 20, 25}

// GroupCosts represents the cost for each group size.
// Group of size 1 is associated with index 0.
var groupCosts [seriesSize]int

func init() {
	for i := 0; i < seriesSize; i++ {
		groupCosts[i] = 800 * (i + 1) * (100 - discounts[i]) / 100
	}
}

// Order represents the number of each book in an order.
// Index 0 corresponds to the number of 1st books in the series.
type order [seriesSize]int

// NewOrder computes the number of each book in the customer order.
// Since rebates are the same regardless of the specific books in a grouping
// as long as they are different, the order is sorted by increasing number of
// books (i.e. index 0 may not be the 1st book but the book with the smallest
// amount in the order).
func NewOrder(books []int) order {
	res := order{}
	for _, book := range books {
		res[book-1] += 1
	}
	slices.Sort(res[:])
	return res
}

// FindBestGrouping computes the best  (i.e. largest grouping)
// from the order.
// Index 0 corresponds to the number of books bought individually.
// Index 4 corresponds to the number of groupings of 5 books.
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

// RemoveGroup removes all the book from n group of groupSize
// from the order.
func (s order) removeGroup(groupSize, n int) order {
	for i := seriesSize - groupSize; i < seriesSize; i++ {
		s[i] -= n
	}
	return s
}

// CombineGroups combines all the books from the groupings
// of size larger than downToBookSize into the groupings of
// size downToBookSize.
//
// if we have 1 group of 5, 1 group of 3 and 3 individual books,
// the order looks like [1 1 2 2 5]. If we are not interested in
// group of size larger than 3, we can reshuffle the order by combining
// the number of books in groups 5 and 4 into 3 giving us the order [0 0 4 2 5]
// which combineGroups reorder to [0 0 2 4 5]. We can do this because the books
// in group 5, 4, and 3 are independent of the books in group 2 and 1.
func (s order) combineGroups(downToBookSize int) order {
	sum := 0
	for i := 0; i < seriesSize-downToBookSize; i++ {
		sum += s[i]
		s[i] = 0
	}
	s[seriesSize-downToBookSize] += sum
    slices.Sort(s[:])
	return s
}

// FindAllGrouping generates all possible alternate groupings for
// the order. (ex: 5+3 and 4+4).
//
// Note: The algorithm below may generate duplicates. In our case
// this doesn't matter as the minimum price computation is not impacted.
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

// Min computes the minimum of integers a and b.
func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

// Grouping represents the number of group of each size for a given
// way to partition the books in an order.
// Index 0 corresponds to the number of groups of size 1 (individual).
// Index 4 corresponds to the number of groups of size 5.
type grouping [seriesSize]int

func (g grouping) largestGroupSize() int {
	for i := seriesSize - 1; i > 0; i-- {
		if g[i] != 0 {
			return i + 1
		}
	}
	return g[0]
}

// Cost computes the cost of the grouping.
func (g grouping) cost() int {
	total := 0
	for i := 0; i < seriesSize; i++ {
		total += groupCosts[i] * g[i]
	}
	return total
}

// Cost computes the best price for a set of books.
func Cost(books []int) int {
	order := NewOrder(books)
	allGroups := order.findAllGrouping()
	bestPrice := allGroups[0].cost()
	for i := 0; i < len(allGroups); i++ {
		bestPrice = min(bestPrice, allGroups[i].cost())
	}
	return bestPrice
}
