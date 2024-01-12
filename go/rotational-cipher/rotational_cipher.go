package rotationalcipher

import "unicode"

func RotationalCipher(plain string, shiftKey int) string {
	runes := []rune(plain)

	for i, c := range runes {
		if unicode.IsLetter(c) {
			runes[i] = rotateCharacter(c, shiftKey)
		}
	}
	return string(runes)
}

func rotateCharacter(c rune, shiftKey int) rune {
	var base rune = 'A'

	if unicode.IsLower(c) { base = 'a' }
	return ((c - base) + rune(shiftKey)) % 26 + base
}
