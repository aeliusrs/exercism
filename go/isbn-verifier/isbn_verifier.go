package isbn

import (
	"strings"
)

func getNumber(isbn string) string {
	var num strings.Builder

	num.Grow(20)
	for _, c := range isbn {
		if c != '-' { num.WriteRune(c) }
	}
	return num.String()
}

func IsValidISBN(isbn string) bool {
	num := getNumber(strings.ToUpper(isbn))

	if len(num) != 10 { return false }
	
	sum := 0
	for i := 0; i < 10; i++ {
		if i == 9 && num[i] == 'X' {
			sum += 10
		} else {
			sum += int(num[i] - '0') * (10 - i)
		}
	}
	return sum % 11 == 0
}
