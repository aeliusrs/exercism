package acronym

import "strings"

func splitter(r rune) bool { return r == ' ' || r == '-' }

func Abbreviate(s string) string {
	var ret strings.Builder

	s = strings.ReplaceAll(s, "_", "")
	s = strings.ToUpper(s)
	splitted := strings.FieldsFunc(s, splitter)
	for _, sub := range splitted {
		ret.WriteByte(sub[0])
	}
	return ret.String()
}
