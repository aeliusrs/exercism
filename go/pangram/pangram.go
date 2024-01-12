package pangram

import "strings"

func IsPangram(input string) bool {
	letterCount := make(map[rune]int)

	for _, char := range strings.ToLower(input) {
		if char >= 'a' && char <= 'z' {
			letterCount[char]++
		}
	}

	return len(letterCount) == 26
}
