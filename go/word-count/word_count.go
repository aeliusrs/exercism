package wordcount

import (
	"strings"
	"regexp"
)

type Frequency map[string]int

func WordCount(phrase string) Frequency {
	var acc = make(Frequency)
	phrase = strings.ToLower(phrase)
	words := regexp.MustCompile(`\b[\w']+\b`).FindAllString(phrase, -1)

	for _, w := range words { acc[w]++ }
	return acc
}
