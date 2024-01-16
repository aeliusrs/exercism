package atbash

import "unicode"
import "strings"

func Atbash(s string) string {
	var group int
	var acc strings.Builder

	s = strings.ToLower(s)
	for _, c := range s {
		if unicode.IsLower(c) {
			acc.WriteRune('a' + 'z' - c)
			group++
			if group % 5 == 0 { acc.WriteRune(' ') }
		} else if unicode.IsDigit(c) {
			acc.WriteRune(c)
			group++
			if group % 5 == 0 { acc.WriteRune(' ') }
		}
	}
	return strings.TrimSpace(acc.String())
}
