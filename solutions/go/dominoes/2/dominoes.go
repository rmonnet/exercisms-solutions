package dominoes

// Define the Domino type here.
type Domino [2]int

func completeChain(chain []Domino, links []Domino) []Domino {
	// This function is always called in a context where len(chain) >= 1.
	if len(links) == 0 && chain[0][0] == chain[len(chain)-1][1] {
		return chain
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
		newLinks := append(append([]Domino{}, links[:i]...), links[i+1:]...)
		solution := completeChain(newChain, newLinks)
		// We only need one solution, returns the first one found.
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
	// Since we are making a circular chain, it doesn't matter
	// which of the domino is first. We may as well pick the first one.
	// We don't have to reverse the first domino either since if there is
	// a solution, reversing the first domino would provide the exact same solution
	// with all the dominoes
	startingChain := []Domino{input[0]}
	startingLinks := append([]Domino{}, input[1:]...)
	solution := completeChain(startingChain, startingLinks)
	return solution, len(solution) > 0
}
