package romannumerals

import "strings"
import "errors"

func translate(in int) (string, int) {
	switch {
	case in <= 0: return "", -1
	case in >= 1000: return "M", 1000
	case in >= 900: return "CM", 900
	case in >= 500: return "D", 500
	case in >= 400: return "CD", 400
	case in >= 100: return "C", 100
	case in >= 90: return "XC", 90
	case in >= 50: return "L", 50
	case in >= 40: return "XL", 40
	case in >= 10: return "X", 10
	case in == 9: return "IX", 9
	case in >= 5: return "V", 5
	case in == 4: return "IV", 4
	default: return "I", 1
	}
}

func ToRomanNumeral(input int) (string, error) {
	if input <= 0 || input > 3999 {
		return "", errors.New("input must be in range")
	}

	var acc strings.Builder

	for input > 0 {
		str, sub := translate(input)

		if sub == -1 { return "", errors.New("something wrong happened") }

		acc.WriteString(str)
		input -= sub
	}
	return acc.String(), nil
}
