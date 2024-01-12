package resistorcolorduo

var Resistor = map[string]int{
		"black": 0, "brown": 1, "red": 2, "orange": 3,
		"yellow": 4, "green": 5, "blue": 6, "violet": 7,
		"grey": 8, "white": 9,
	}

// Value should return the resistance value of a resistor with a given colors.
func Value(colors []string) (sum int) {
	for i, c := range colors {
		v, ok := Resistor[c]
		if ok && i < 2 { sum = (sum * 10) + v }
	}
	return
}
