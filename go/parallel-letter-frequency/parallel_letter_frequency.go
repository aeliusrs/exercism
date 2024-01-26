package letter

type FreqMap map[rune]int

func Frequency(text string) FreqMap {
	frequencies := FreqMap{}
	for _, r := range text {
		frequencies[r]++
	}
	return frequencies
}

func ConcurrentFrequency(texts []string) FreqMap {
	ch := make(chan FreqMap)
	defer close(ch)

	for _, t := range texts {
		go func(t string) { ch <- Frequency(t) }(t)
	}

	acc := FreqMap{}
	for range texts {
		for k, v := range <- ch { acc[k] += v }
	}
	return acc
}
