package allergies

var allergenTable = map[string]uint{
	"eggs": 1,
	"peanuts": 2,
	"shellfish": 4,
	"strawberries": 8,
	"tomatoes": 16,
	"chocolate": 32,
	"pollen": 64,
	"cats": 128,
}

func Allergies(allergies uint) (acc []string) {
	for k, _ := range allergenTable {
		if AllergicTo(allergies, k) {
			acc = append(acc, k)
		}
	}
	return
}

func AllergicTo(allergies uint, allergen string) bool {
	v, ok := allergenTable[allergen]

	if !ok { return false }
	return v == (allergies & v)
}
