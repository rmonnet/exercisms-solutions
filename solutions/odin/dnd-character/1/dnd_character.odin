package dnd_character

import "core:math/rand"

Character :: struct {
    strength: int,
    dexterity: int,
    constitution: int,
    intelligence: int,
    wisdom: int,
    charisma: int,
    hitpoints: int,
}

modifier :: proc(score: int) -> int {
    base := score - 10
	return base > 0 ? base / 2 : (base -1) / 2
}

ability :: proc() -> int {

	score := 0
    smallest := 7
    for i in 0..<4 {
      roll := 1 + rand.int_max(6)
      score += roll
      if roll < smallest {
        smallest = roll
      }
    }
    score -= smallest
    return score
}

character :: proc() -> Character {

    constitution := ability()
	return Character {
        strength = ability(),
        dexterity = ability(),
        constitution = constitution,
        intelligence = ability(),
        wisdom = ability(),
        charisma = ability(),
        hitpoints = 10 + modifier(constitution)
    }
}
