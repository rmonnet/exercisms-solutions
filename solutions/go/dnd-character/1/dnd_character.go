package dndcharacter

import (
    "math"
    "math/rand"
)

type Character struct {
	Strength     int
	Dexterity    int
	Constitution int
	Intelligence int
	Wisdom       int
	Charisma     int
	Hitpoints    int
}

// Modifier calculates the ability modifier for a given ability score
func Modifier(score int) int {
    return int(math.Floor(float64(score - 10) / 2))
}

func dice6() int {
    return 1 + rand.Intn(6)
}

// Ability uses randomness to generate the score for an ability
func Ability() int {
	min := dice6()
    sum := 0
    for i := 0; i < 3; i++ {
        draw := dice6()
        if draw < min {
            sum += min
            min = draw
        } else {
            sum += draw
        }
    }
    return sum
}

// GenerateCharacter creates a new Character with random scores for abilities
func GenerateCharacter() Character {
    var c Character
	c. Strength  = Ability()
	c.Dexterity = Ability()
	c.Constitution = Ability()
	c.Intelligence = Ability()
	c.Wisdom  = Ability()
	c.Charisma  = Ability()
	c.Hitpoints = 10 + Modifier(c.Constitution)
    return c
}
