package proverb

import "fmt"


func Proverb(rhyme []string) (acc []string) {
	if len(rhyme) < 1 { return }

	for i := 0; i < len(rhyme) - 1; i++ {
		fst := rhyme[i]
		snd := rhyme[i + 1]
		str := fmt.Sprintf("For want of a %s the %s was lost.", fst, snd)
		acc = append(acc, str)
	}
	str := fmt.Sprintf("And all for the want of a %s.", rhyme[0])
	acc = append(acc, str)
	return
}
