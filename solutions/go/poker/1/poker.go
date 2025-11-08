package poker

import (
	"cmp"
	"fmt"
	"regexp"
	"slices"
	"strings"
)

/*
Algorithm to find the category of a poker hand:

source: http://nsayer.blogspot.com/2007/07/algorithm-for-evaluating-poker-hands.html

categories are in descending order: straight-flush, four-of-a-kind, full-house, flush, straight,
three-of-a-kind, two-pairs, one-pair and high-hand.

Take a histogram of the card ranks
Sort the histogram in descending order:

histogram counts = (4, 1): four-of-a-kind.
histogram counts = (3, 2): full-house.
histogram counts = (3, 1, 1): three-of-a-kind.
histogram counts = (2, 2, 1): two-pairs.
histogram size = 4: one-pair.

then look at the (rank, suit) combination
5 cards of the same suit: flush
sort cards by descending ranks.
rank[0]-rank[4] == 4: straight
if flush and straight: straight-flush

otherwise (size = 5): high-card.

Algorithm to sort the categories by values:

We need a tie-breaker when we get two hands of the same category
We will use numerical values to order the categories and for the tie-breaker.
To allow this we convert ranks to numerical value with rank "2" = 2 and rank "A" = 14.
(We start at 2 rather than 0 to simplify debugging, the numerical ranks match their value).

The tie-breaker for a high-hand must consider the highest rank first, then the next,
possibly all the way to the lowest card. We use base 15 since this ensure that the 2nd
highest rank will have a lower value than the 1st lowest rank.

Assuming the cards are sorted by descending rank in an array called ranks:
high-card value = ranks[0] * 15^4 + ranks[1] * 15^3 + ranks[2] * 15^2 + ranks[3] * 15^1 + ranks[4] * 15^0

Since all other categories must have a higher value than high-card, we give each of them
an additional left digit:

one-pair value = 1 * 15^5 + one-pair tie-breaker
two-pairs value = 2 * 15^5 + two-pair tie-breaker
...
straight-flush value = 8 * 15^5 + straight-flush tie-breaker.

Assuming a tie-breaker use all five cards, its value would still be lower than 15^5 (see high-card value)
and would not overflow in the next category up.

The tie-breakers are computed as follow: (hist is sorted by descending count and ranks by descending rank)

straight-flush: rank[0]
four-of-a-kind: hist[0].rank * 15 + hist[1].rank
full-house: hist[0].rank * 15 + hist[1].rank
flush: ranks[0] * 15^4 + ranks[1] * 15^3 + ranks[2] * 15^2 + ranks[3] * 15 + ranks[4]
straight: rank[0]
three-of-a-kind: hist[0].rank * 15^2 + hist[1].rank * 15 + hist[2].rank
two-pairs: h,l are indexes of the highest/lowest pairs in the histogram
           hist[h].rank * 15^2 + hist[l].rank * 15 + hist[2].rank
one-pair: p is index of pair in histogram, ranks' is ranks with pair removed
          hist[p].rank * 15^3 + ranks'[0] * 15^2 + ranks'[1] * 15 + ranks'[0]
high-hand: ranks[0] * 15^4 + ranks[1] * 15^3 + ranks[2] * 15^2 + ranks[3] * 15 + ranks[4]

Note: if the histogram is sorted by descending count, then descending rank, then rank[i]
array can be replace by hist[i].rank in the tie-breaker above.
*/

// CardRe is the regular expression defining a poker card (rank suit).
var cardRe = regexp.MustCompile(`^(([2-9JQKA]|10)([♤♡♢♧]))$`)

// Values represents the numerical values associated with each card rank.
// They are used to order the cards within a hand.
var values = map[string]int{"2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8,
	"9": 9, "10": 10, "J": 11, "Q": 12, "K": 13, "A": 14}

// AceValue is the numerical value associated with an ace.
var aceValue = values["A"]

// Base is the number base used to compute the value of a hand. The value
// of a hand is based on a number in base Base using for digits the values
// of the card in descending rank order.
var base = aceValue + 1
var base5 = base * base * base * base * base

// Value (*base5) of each poker category (without the tie-breaker).
const (
	highHand = iota
	onePair
	twoPairs
	threeOfaKind
	straight
	flush
	fullHouse
	fourOfaKind
	straightFlush
)

// Freq represents the frequency of a rank within a hand.
type freq struct {
	rank  int
	count int
}

// Hist represents the hand histogram.
type hist struct {
	ranks       []freq
	largestSuit int
}

// TieBreaker computes the tie-breaker value of a histogram for the
// selected indexes. Indexes represents the cards to be included in the
// computation of the tie-breaker.
func (h hist) tieBreaker(indexes ...int) int {
	value := 0
	for _, index := range indexes {
		value = value*base + h.ranks[index].rank
	}
	return value
}

// Value computes the value of a hand histogram.
// The value is based  on the hand category
// augmented with a tie-breaker value.
func (h hist) value() int {

	// Look for four-of-a-kind.
	if h.ranks[0].count == 4 {
		return fourOfaKind*base5 + h.tieBreaker(0, 1)
	}
	// Look for full-house.
	if h.ranks[0].count == 3 && h.ranks[1].count == 2 {
		return fullHouse*base5 + h.tieBreaker(0, 1)
	}
	// Look for  three-of-a-kind.
	if h.ranks[0].count == 3 {
		return threeOfaKind*base5 + h.tieBreaker(0, 1, 2)
	}
	// Look for two-pairs.
	if h.ranks[0].count == 2 && h.ranks[1].count == 2 {
		return twoPairs*base5 + h.tieBreaker(0, 1, 2)
	}
	// Look for one-pair.
	if h.ranks[0].count == 2 {
		return onePair*base5 + h.tieBreaker(0, 1, 2, 3)
	}
	// Look for straight and straight-flush.
	// Special case: the Ace can start a straight A-2-3-4-5.
	if len(h.ranks) == 5 && ((h.ranks[0].rank-h.ranks[4].rank) == 4 ||
		(h.ranks[0].rank == aceValue && h.ranks[1].rank == 5 && (h.ranks[1].rank-h.ranks[4].rank) == 3)) {
		// In a  straight, ace counts as 1 and is the lowest card.
		highestCard := 0
		if h.ranks[0].rank == aceValue {
			highestCard = 1
		}
		if h.largestSuit == 5 {
			return straightFlush*base5 + h.tieBreaker(highestCard)
		} else {
			return straight*base5 + h.tieBreaker(highestCard)
		}
	}
	// Look for flush.
	if h.largestSuit == 5 {
		return flush*base5 + h.tieBreaker(0, 1, 2, 3, 4)
	}
	// high-card
	return h.tieBreaker(0, 1, 2, 3, 4)
}

// ParseHand generates the histogram for a hand based on its string
// representation. It generates an error if the string is not a valid hand.
func parseHand(hand string) (hist, error) {
	cards := strings.Split(hand, " ")
	if len(cards) != 5 {
		return hist{}, fmt.Errorf("5 cards not properly separated: %q", hand)
	}
	rankHist := map[int]int{}
	suitHist := map[string]int{}
	for _, card := range cards {
		rep := cardRe.FindStringSubmatch(card)
		if rep == nil {
			return hist{}, fmt.Errorf("invalid card: %q", card)
		}
		rankHist[values[rep[2]]] += 1
		suitHist[rep[3]] += 1
	}
	res := hist{}
	for rank, count := range rankHist {
		res.ranks = append(res.ranks, freq{rank: rank, count: count})
	}
	for _, count := range suitHist {
		if count > res.largestSuit {
			res.largestSuit = count
		}
	}
	slices.SortFunc(res.ranks, func(a, b freq) int {
		cmpCount := cmp.Compare(a.count, b.count)
		if cmpCount != 0 {
			return -cmpCount
		}
		return -cmp.Compare(a.rank, b.rank)
	})
	return res, nil
}

func BestHand(hands []string) ([]string, error) {
	handValues := make([]int, len(hands))
	bestValue := 0
	for i, hand := range hands {
		h, err := parseHand(hand)
		if err != nil {
			return []string{}, fmt.Errorf("cannot parse hand %q: %w", hand, err)
		}
		handValues[i] = h.value()
		if handValues[i] > bestValue {
			bestValue = handValues[i]
		}
	}
	best := []string{}
	for i, value := range handValues {
		if value == bestValue {
			best = append(best, hands[i])
		}
	}
	return best, nil
}
