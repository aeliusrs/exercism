package isogram

import (
	"unicode"
	"strings"
)

func IsIsogram(word string) bool {
	word = strings.ToLower(word)

	for _, c := range word {
		if unicode.IsLetter(c) && strings.Count(word, string(c)) > 1 {
			return false
		}
	}
	return true
}
