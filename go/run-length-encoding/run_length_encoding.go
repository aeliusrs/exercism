package encode

import "strings"
import "strconv"

// this refactoring is inspired by kdobmayer's
func RunLengthEncode(input string) string {
	var acc strings.Builder

	for len(input) > 0 {

		letter := input[0]
		slen := len(input)
		input = strings.TrimLeft(input, string(letter))

		if n := slen - len(input); n > 1 {
			acc.WriteString(strconv.Itoa(n))
		}
		acc.WriteByte(letter)
	}
	return acc.String()
}

func RunLengthDecode(input string) string {
	var acc strings.Builder

	rep := 0
	for _, c := range input {
		if c >= '0' && c <= '9' {
			rep = rep * 10 + int(c -'0')
		} else {
			acc.WriteRune(c)
			for ; rep > 1; rep -- {
				acc.WriteRune(c)
			}
			rep = 0
		}
	}
	return acc.String()
}
