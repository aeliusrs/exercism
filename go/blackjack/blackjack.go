package blackjack

// ParseCard returns the integer value of a card following blackjack ruleset.
func ParseCard(card string) int {
	switch {
		case card == "ace": return 11
		case card == "two": return 2
		case card == "three": return 3
		case card == "four": return 4
		case card == "five": return 5
		case card == "six": return 6
		case card == "seven": return 7
		case card == "eight": return 8
		case card == "nine": return 9
		case card == "ten": return 10
		case card == "jack": return 10
		case card == "queen": return 10
		case card == "king": return 10
		default: return 0
	}
}

// FirstTurn returns the decision for the first turn, given two cards of the
// player and one card of the dealer.
func FirstTurn(card1, card2, dealerCard string) string {
	value1 := ParseCard(card1)
	value2 := ParseCard(card2)
	dealer := ParseCard(dealerCard)
	combine := value1 + value2
	switch {
		case value1 == 11 && value2 == 11: return "P"
		case combine == 21 && dealer < 10: return "W"
		case combine == 21 && dealer > 9: return "S"
	    case combine >= 17: return "S"
	    case combine >= 12 && combine <= 16 && dealer >= 7: return "H"
	    case combine >= 12 && combine <= 16 && dealer < 7: return "S"
		default: return "H"
	}
}
