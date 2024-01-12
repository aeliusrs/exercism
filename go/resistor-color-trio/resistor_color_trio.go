package resistorcolortrio

import (
	"math"
	"fmt"
)

var Res = map[string]int{
		"black": 0, "brown": 1, "red": 2, "orange": 3,
		"yellow": 4, "green": 5, "blue": 6, "violet": 7,
		"grey": 8, "white": 9,
	}

func Label(colors []string) string {
	sum := (Res[colors[0]] * 10 + Res[colors[1]]) * int(math.Pow10(Res[colors[2]]))

	switch {
		case sum/10e8 > 1: return fmt.Sprintf("%d gigaohms", sum/10e8)
		case sum/10e5 > 1: return fmt.Sprintf("%d megaohms", sum/10e5)
		case sum/10e2 > 1: return fmt.Sprintf("%d kiloohms", sum/10e2)
		default: return fmt.Sprintf("%d ohms", sum)
	}
}
