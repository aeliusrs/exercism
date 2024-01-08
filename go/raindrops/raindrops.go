package raindrops

import "strconv"

var content = []struct {
	nb  int
	str string
}{ {3, "Pling"}, {5, "Plang"}, {7, "Plong"} }

func Convert(number int) (acc string) {
	for _, el := range content { if number % el.nb == 0 { acc += el.str } }
	if acc == "" { acc = strconv.Itoa(number) }
	return
}
