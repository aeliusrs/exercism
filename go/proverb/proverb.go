package proverb

import "fmt"

const line = "For want of a %s the %s was lost."
const final = "And all for the want of a %s."

func Proverb(rhyme []string) (acc []string) {
	if len(rhyme) < 1 { return }

	for i, _ := range rhyme[:len(rhyme) - 1] {
		acc = append(acc, fmt.Sprintf(line, rhyme[i], rhyme[i + 1]))
	}
	return append(acc, fmt.Sprintf(final, rhyme[0]))
}
