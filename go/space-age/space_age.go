package space

type Planet string

const earthSec = 31557600.0

func getOrbit(planet Planet) float64 {
	switch planet {
		case "Mercury": return 0.2408467
		case "Venus": return 0.61519726
		case "Earth": return 1.0
		case "Mars": return 1.8808158
		case "Jupiter": return 11.862615
		case "Saturn": return 29.447498
		case "Uranus": return 84.016846
		case "Neptune": return 164.7913
		default: return -1.0
	}
}

func Age(seconds float64, planet Planet) float64 {
	orbit := getOrbit(planet)

	if orbit == -1.0 { return orbit }
	return seconds / (earthSec * orbit)
}
