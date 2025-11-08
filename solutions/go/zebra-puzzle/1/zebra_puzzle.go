package zebra

import (
	"fmt"
)

const (
	nvars   = 25
	grpsize = 5
	nhouses = 5
)

// We have 25 variables in groups of 5 (color, nationality, animal, cigarette, and drink).
// Each needs to be allocated to a house (1 to 5) where 1 is the house on the left and 5 the house
// on the right. (0 is used when no house is selected).
//
// We could have treated each of the group as a different dimension but this would cause us
// to have special structures and logic for each group. Instead we treat them as a single group with
// additional constraints (ex: no two of the five color can be allocated to the same house).
//
// The order of the variables (defined in a const below) should not change the result (if there is
// only one solution) but impact the number of steps before we get to the solution. If we wanted to
// optimize, we would need to order the variables in an order so that tentative solution fails fast
// pruning the search tree. In practice the "unordered" list below reaches the solution in 907 steps
// which is good enough.
//
// We define the problem as a set of 25 variables containing a value from 0 to 5.
//     0 means the variable is unassigned (free variable).
//     1-5 means the variable is assigned to a house location (1 left, 5 right).
//
// We are using a backtracking algorithm
//
// Start with an initial problem
// call backtrack(initial problem)
//
// backtrack(problem) is a recursive function
//     if there is no free variable
//         if the problem satisfies the constraints then we found A solution (stop there)
//         if the problem doesn't satisfy the constraints return
//     pick a free variable (unassigned)
//     for all the houses unallocated for the category of the free variable (ex: colors, nationalities, ...)
//         assign unallocate house to free variable (new problem)
//         if new problem satisfies the constraints then call backtrack(new problem)
//
// The function satisfiesConstraint checks all the rules (but rules 1, 9 and 10) with simple logic.
// example: "The Englishman lives in the red house" is verified by problem[englishman] == problem[redHouse]
// and both englishman and redHouse are assigned variables (value is between 1-5).
//
// Rule #1 "There are five houses" is head-coded in the problem definition (house locations from 1 to 5).
// Rule #9 "Milk is drunk in the middle house" is hard-coded in the initial problem (problem[milk]=3).
// Rule #10 "The Norwegian lives in the first house" is hard-coded in the initial problem (problem[norwegian]=1).
//
// We could probably find other optimizations to kickstart the rules (for example once you hard-coded Rule #10,
// it would be easy to hard code Rule #15 "The Norwegian lives next to the blud house" as p[blue]=2) but in this case,
// the algorithm is fast enough.

// House represents the house locations.
type house int

// Rule #1 - There are five houses.
const (
	leftHouse house = iota + 1
	secondHouse
	middleHouse
	fourthHouse
	rightHouse
)

// Nohouse is a special value to represent cases where house location hasn't been allocated
// to a variable yet.
const nohouse house = 0

// Variable represents the type of the problem variables (the 25 properties to allocate to house locations).
type variable int

// The list of variable can be tweak to reduce the number of steps in backtrack.
const (
	redHouse variable = iota
	greenHouse
	yellow
	ivoryHouse
	blue

	englishman
	spaniard
	ukrainian
	norwegian
	japanese

	dog
	snail
	horse
	fox
	zebra

	oldGold
	kools
	chesterfields
	luckyStrike
	parliaments

	coffee
	tea
	milk
	orangeJuice
	water
)

// Solution defines the answer to the problem two questions.
type Solution struct {
	DrinksWater string
	OwnsZebra   string
}

// SolvePuzzle returns the first solution found to the problem.
func SolvePuzzle() Solution {
	initialPb := InitialProblem()
	solvedPb, success := initialPb.backtrack()
	if !success {
		panic("no solution found!")
	}
	waterDrinker, ok := solvedPb.liveInSameHouse(nationalities, water)
	if !ok {
		panic("nobody leaves in the house where they drink water")
	}
	zebraOwner, ok := solvedPb.liveInSameHouse(nationalities, zebra)
	if !ok {
		panic("nobody lives in the house where the zebra lives")
	}
	return Solution{DrinksWater: waterDrinker.String(), OwnsZebra: zebraOwner.String()}
}

// Problem defines an allocation for each of the 25 variables.
// Each index correspond to a variable.
// Each value correspond to a house location (1-5, 0=unassigned).
// Methods defined on problem are engineered so that problem is immutable,
// and we don't have to undo changes when backtracking.
type problem [nvars]house

// InitialProblem construct an initial problem.
// It hard-code rules with obvious solutions (9, 10) to reduce the search space.
func InitialProblem() problem {
	p := problem{}
	// Rule #9 - Milk is drunk in the middle house.
	p = p.assign(milk, middleHouse)
	// Rule #10 - The Norwegian lives in the first house.
	p = p.assign(norwegian, leftHouse)
	return p
}

// Backtrack performs the search by calling Backtrack() recursively on all
// the possible solutions (free houses) for a given free variable.
// It returns the first solution found or false when it reaches an impass.
func (p problem) backtrack() (problem, bool) {
	v, ok := p.firstFreeVariable()
	if !ok {
		return p, p.satifiesConstraints()
	}
	freeHouses := p.freeHousesForCat(varCat[v])
	for _, h := range freeHouses {
		newP := p.assign(v, h)
		if newP.satifiesConstraints() {
			sol, ok := newP.backtrack()
			if ok {
				return sol, ok
			}
		}
	}
	return p, false
}

// SatisfiesConstraints checks if a problem passes all the rules.
// Rules hard-coded in the initial problem are not checked here.
func (p *problem) satifiesConstraints() bool {
	// Rule #2 - The Englishman lives in the red house.
	if p.notInSameHouse(englishman, redHouse) {
		return false
	}
	// Rule #3 - The Spaniard owns the dog.
	if p.notInSameHouse(spaniard, dog) {
		return false
	}
	// Rule #4 - Coffee is drunk in the green house.
	if p.notInSameHouse(coffee, greenHouse) {
		return false
	}
	// Rule #5 - The Ukrainian drinks tea.
	if p.notInSameHouse(ukrainian, tea) {
		return false
	}
	// Rule #6 - The green house is immediately to the right of the ivory house.
	if p.notToTheRight(greenHouse, ivoryHouse) {
		return false
	}
	// Rule #7 - The Old Gold smoker owns snails.
	if p.notInSameHouse(oldGold, snail) {
		return false
	}
	// Rule #8 - Kools are smoked in the yellow house.
	if p.notInSameHouse(kools, yellow) {
		return false
	}

	// Rule #9 - Milk is drunk in the middle house.
	// Implemented in InitializeProblem - always true

	// Rule #10 - The Norwegian lives in the first house.
	// Implemented in InitializeProblem - always true

	// Rule #11 - The man who smokes Chesterfields lives in the house next to the man with the fox
	if p.notNextDoor(chesterfields, fox) {
		return false
	}

	// Rule #12 - Kools are smoked in the house next to the house where the horse is kept.
	if p.notNextDoor(kools, horse) {
		return false
	}

	// Rule #13 - The Lucky Strike smoker drinks orange juice.
	if p.notInSameHouse(luckyStrike, orangeJuice) {
		return false
	}

	// Rule #14 - The Japanese smokes Parliaments.
	if p.notInSameHouse(japanese, parliaments) {
		return false
	}

	// Rule #15 - The Norwegian lives next to the blue house.
	if p.notNextDoor(norwegian, blue) {
		return false
	}

	return true
}

// Assign assigns a house location to a free variable.
func (p problem) assign(v variable, h house) problem {
	// Sanity check to detect algorithm errors.
	if p[v] != 0 {
		panic(fmt.Sprintf("Attempted to assign variable %s twice: has location %d and %d",
			varNames[v], p[v], h))
	}
	p[v] = h
	return p
}

// IsFree checks if a variable is unassigned.
func (p *problem) isFree(v variable) bool {
	return p[v] == nohouse
}

// FreeHousesForCat returns the houses that are unallocated for the given
// category. This implements the implicit constraint that for each category,
// each variable must be allocated a different house.
func (p *problem) freeHousesForCat(cat [grpsize]variable) []house {
	assigned := [nhouses]bool{}
	for _, v := range cat {
		if p[v] != nohouse {
			assigned[p[v]-1] = true
		}
	}
	res := []house{}
	for h := leftHouse; h <= rightHouse; h++ {
		if !assigned[h-1] {
			res = append(res, h)
		}
	}
	return res
}

// FirstFreeVariable returns the first free variable for the given problem.
// It return false as second parameter if all variables are allocated.
func (p *problem) firstFreeVariable() (variable, bool) {
	for v := variable(0); v < nvars; v++ {
		if p.isFree(v) {
			return v, true
		}
	}
	return variable(0), false
}

// AreAssigned checks if the two given variables are assigned.
// If at least one is not, there is no point checking rules
// associated with the two variables.
func (p *problem) areAssigned(v1, v2 variable) bool {
	return p[v1] != nohouse && p[v2] != nohouse
}

// NotInSameHouse checks if both variables are assigned
// and not associated to the same house.
// This is used to implement some of the rules.
func (p *problem) notInSameHouse(v1, v2 variable) bool {
	return p.areAssigned(v1, v2) && p[v1] != p[v2]
}

// NotNextDoor checks if both variables are assigned
// and not associated to neighbor houses.
// This is used to implement some of the rules.
func (p *problem) notNextDoor(v1, v2 variable) bool {
	if !p.areAssigned(v1, v2) {
		return false
	}
	distance := p[v1] - p[v2]
	return !(distance == 1 || distance == -1)

}

// NotToTheRight checks if both variables are assigned
// and the first is not to the right of the second.
// This is used to implement some of the rules.
func (p *problem) notToTheRight(v1, v2 variable) bool {
	return p.areAssigned(v1, v2) && p[v1] != p[v2]+1
}

// LiveInSameHouse returns the variable from the given category that lives in the
// same house as the given variable.
func (p *problem) liveInSameHouse(cat [grpsize]variable, as variable) (variable, bool) {
	for _, v := range cat {
		if p[v] == p[as] {
			return v, true
		}
	}
	return variable(0), false
}

// VarNames contains the names of the different variables (used by variable.String()).
var varNames = map[variable]string{
	redHouse: "Red", greenHouse: "Green", yellow: "Yellow", ivoryHouse: "Ivory", blue: "Blue",
	englishman: "Englishman", spaniard: "Spaniard", ukrainian: "Ukrainian", norwegian: "Norwegian", japanese: "Japanese",
	dog: "Dog", snail: "Snail", horse: "Horse", fox: "Fox", zebra: "Zebra",
	oldGold: "Old Gold", kools: "Kools", chesterfields: "Chesterfields", luckyStrike: "Lucky Strike", parliaments: "Parliaments",
	coffee: "Coffee", tea: "Tea", milk: "Milk", orangeJuice: "Orange Juice", water: "Water"}

// String converts a variable to its string representation.
func (v variable) String() string {
	name, ok := varNames[v]
	if !ok {
		return "unknown"
	}
	return name
}

// Defines the 5 categories of variables.
var colors = [grpsize]variable{redHouse, greenHouse, yellow, ivoryHouse, blue}
var nationalities = [grpsize]variable{englishman, spaniard, ukrainian, norwegian, japanese}
var animals = [grpsize]variable{dog, snail, horse, fox, zebra}
var cigarettes = [grpsize]variable{oldGold, kools, chesterfields, luckyStrike, parliaments}
var drinks = [grpsize]variable{coffee, tea, milk, orangeJuice, water}

// Defines the category each variable belongs to.
var varCat = map[variable][grpsize]variable{
	redHouse: colors, greenHouse: colors, yellow: colors, ivoryHouse: colors, blue: colors,
	englishman: nationalities, spaniard: nationalities, ukrainian: nationalities, norwegian: nationalities, japanese: nationalities,
	dog: animals, snail: animals, horse: animals, fox: animals, zebra: animals,
	oldGold: cigarettes, kools: cigarettes, chesterfields: cigarettes, luckyStrike: cigarettes, parliaments: cigarettes,
	coffee: drinks, tea: drinks, milk: drinks, orangeJuice: drinks, water: drinks}
