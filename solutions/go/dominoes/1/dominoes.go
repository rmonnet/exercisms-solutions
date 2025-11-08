package dominoes

// Define the Domino type here.
type Domino [2]int

func removeLink(chain []Domino, i int) []Domino {
	// Due to the nature of append, it will reslice the 1st argument if it has sufficient capacity.
	// This leads to the case where append(chain[:i], chain[i+1:]...) modifies the original chain,
	// even if it returns a new address for the resulting slice.
	// Copying the slice into an empty slice first leaves chain unchanged.
	res := append([]Domino{}, chain[:i]...)
	res = append(res, chain[i+1:]...)
	return res
}

func endsMatch(chain []Domino) bool {
	return len(chain) == 0 || chain[0][0] == chain[len(chain)-1][1]
}

func completeChain(chain []Domino, links []Domino) []Domino {
	// This is called in a context where len(chain) >= 1.
	// No more links. We either have a solution or not.
	if len(links) == 0 {
		if endsMatch(chain) {
			return chain
		}
		return []Domino{}
	}
	lastStone := chain[len(chain)-1][1]
	for i, link := range links {
		if link[0] != lastStone && link[1] != lastStone {
			continue
		}
		newLink := link
		if newLink[0] != lastStone {
			newLink[0], newLink[1] = newLink[1], newLink[0]
		}
		newChain := append(chain, newLink)
		newLinks := removeLink(links, i)
		solution := completeChain(newChain, newLinks)
		// We only need one solution, returns the first one found.
		// If we wanted all the solutions, we would have to store them in a slice of []Domino
		// and keep looping.
		if len(solution) > 0 {
			return solution
		}
	}
	return []Domino{}
}

func MakeChain(input []Domino) ([]Domino, bool) {
	if len(input) == 0 {
		return []Domino{}, true
	}
	if len(input) == 1 {
		if endsMatch(input) {
			return input, true
		}
		return []Domino{}, false
	}
	for i, link := range input {
		// Dominoes are reversible, so we need to try both ways.
		links := removeLink(input, i)
		solution := completeChain([]Domino{link}, links)
		if len(solution) > 0 {
			return solution, true
		}
		swappedLink := Domino{link[1], link[0]}
		solution = completeChain([]Domino{swappedLink}, links)
		if len(solution) > 0 {
			return solution, true
		}
	}
	return []Domino{}, false
}
