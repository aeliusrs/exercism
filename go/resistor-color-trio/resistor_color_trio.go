package resistorcolortrio

import (
	"math"
	"fmt"
)

var Resistor = map[string]int{
		"black": 0, "brown": 1, "red": 2, "orange": 3,
		"yellow": 4, "green": 5, "blue": 6, "violet": 7,
		"grey": 8, "white": 9,
	}

func Label(colors []string) string {
	var label string
	sum := (Resistor[colors[0]] * 10 + Resistor[colors[1]]) *
		int(math.Pow10(Resistor[colors[2]]))

	switch {
	  case sum == 0: label = ""
	  case sum % 1_000_000_000 == 0:
		sum = sum / 1_000_000_000
		label = "giga"
	  case sum % 1_000_000 == 0:
		sum = sum / 1_000_000
		label = "mega"
	  case sum % 1_000 == 0:
		sum = sum / 1_000
		label = "kilo"
	}

	return fmt.Sprintf("%d %sohms", sum, label)
}
