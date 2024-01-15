package anagram

import (
	"sort"
	"strings"
	"unicode"
)

func sanitize(str string) (result []rune) {
	trimmed := strings.TrimSpace(str)
	lowered := strings.ToLower(trimmed)
	runeSlice := []rune(lowered)

	sort.Slice(runeSlice, func(i, j int) bool {
		return runeSlice[i] < runeSlice[j]
	})
	for _, r := range runeSlice {
		if unicode.IsLetter(r) {
			result = append(result, r)
		}
	}
	return
}

func compare(pattern, focus []rune) bool {
	for i, v := range pattern {
		if v != focus[i] { return false }
	}
	return true
}

func Detect(subject string, candidates []string) (result []string) {
	pattern := sanitize(subject)
	subject = strings.ToLower(subject)

	for _, candidate := range candidates {
		focus := sanitize(candidate)

		if subject != strings.ToLower(candidate) &&
		len(pattern) == len(focus) && compare(pattern, focus) {
			result = append(result, candidate)
		}
	}
	return
}
