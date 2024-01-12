package etl

import "strings"

func Transform(in map[int][]string) (m map[string]int) {
	m = make(map[string]int)

	for k, lst := range in {
		for _, s := range lst {
			m[strings.ToLower(s)] = k
		}
	}
	return
}
