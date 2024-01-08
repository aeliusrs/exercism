package triangle

type Kind int

const (
	Equ = 3
	Iso = 2
	Sca = 1
	NaT = 0
)

func isValid (a, b, c float64) bool {
 return a != 0 && b != 0 && c != 0 &&
 (a + b > c) && (b + c > a) && (a + c > b)
}

func isEqu (a, b, c float64) bool {
	return isValid(a, b, c,) && (a == b && b == c && c == a)
}

func isIso (a, b, c float64) bool {
	return isValid(a, b, c,) && (a == b || b == c || c == a)
}

func isSca (a, b, c float64) bool {
	return isValid(a, b, c,) && (a != b && b != c && c != a)
}

func KindFromSides(a, b, c float64) Kind {
	if isEqu(a, b, c) { return Equ }
	if isIso(a, b, c) { return Iso }
	if isSca(a, b, c) { return Sca }
	return NaT
}
