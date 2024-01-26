package diamond

import "strings"
import "errors"

func Gen(char byte) (string, error) {
	if char < 'A' || char > 'Z' { return "", errors.New("not ok") }

	var acc strings.Builder

	slen := int(char - 'A')
	tlen := (slen * 2) + 1

	for i := 0; i <= slen; i++ {
		line := []rune(strings.Repeat(" ", tlen))
		line[slen - i] = rune('A' + byte(i))

		pos := tlen - (slen - i) - 1
		if pos > 0 && pos < tlen { line[pos] = rune('A' + byte(i)) }

		acc.WriteString(string(line))
		if slen > 0 { acc.WriteRune('\n') }
	}

	for i := slen - 1; i >= 0; i-- {
		line := []rune(strings.Repeat(" ", tlen))
		line[slen - i] = rune('A' + byte(i))

		pos := tlen - (slen - i) - 1
		if pos > 0 && pos < tlen { line[pos] = rune('A' + byte(i)) }

		acc.WriteString(string(line))
		if i > 0 { acc.WriteRune('\n') }
	}
	return acc.String(), nil
}
