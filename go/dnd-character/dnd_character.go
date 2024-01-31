package dndcharacter

import "math"
import "math/rand"

type Character struct {
	Strength     int
	Dexterity    int
	Constitution int
	Intelligence int
	Wisdom       int
	Charisma     int
	Hitpoints    int
}

func roll() int { return rand.Intn(6) + 1 }

// Modifier calculates the ability modifier for a given ability score
func Modifier(score int) int {
	return int(math.Floor(float64(score - 10) / 2.0))
}

// Ability uses randomness to generate the score for an ability
func Ability() int {
	sum := 0
	min := 20

	for i := 4; i > 0; i-- {
		roll := roll()
		sum += roll
		if sum < min { min = roll }
	}

	return sum - min
}

// GenerateCharacter creates a new Character with random scores for abilities
func GenerateCharacter() Character {
	avatar := Character{
		Strength:     Ability(),
		Dexterity:    Ability(),
		Constitution: Ability(),
		Intelligence: Ability(),
		Wisdom:       Ability(),
		Charisma:     Ability(),
	}

	avatar.Hitpoints = 10 + Modifier(avatar.Constitution)
	return avatar
}
