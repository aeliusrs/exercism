package foodchain

import "strings"

var lyrics = []struct { animal, second, repeat string }{
	{ "fly", "", "I don't know why she swallowed the fly. Perhaps she'll die." },
	{ "spider", "It wriggled and jiggled and tickled inside her.", "She swallowed the spider to catch the fly." },
	{ "bird", "How absurd to swallow a bird!", "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her." },
	{ "cat", "Imagine that, to swallow a cat!", "She swallowed the cat to catch the bird." },
	{ "dog", "What a hog, to swallow a dog!", "She swallowed the dog to catch the cat." },
	{ "goat", "Just opened her throat and swallowed a goat!", "She swallowed the goat to catch the dog." },
	{ "cow", "I don't know how she swallowed a cow!", "She swallowed the cow to catch the goat." },
	{ "horse", "She's dead, of course!", "" },
}

func Verse(v int) string {
	var sum strings.Builder

	sum.WriteString("I know an old lady who swallowed a ")
	sum.WriteString(lyrics[v - 1].animal)
	sum.WriteString(".\n")

	if v > 1 {
		sum.WriteString(lyrics[v - 1].second)
		if v != 8 { sum.WriteString("\n") }
	}

	for i := v - 1; v < 8 && i >= 0; i-- {
		sum.WriteString(lyrics[i].repeat)
		if i != 0 { sum.WriteString("\n") }
	}
	return sum.String()
}

func Verses(start, end int) string {
	var sum strings.Builder

	for i := start; i <= end; i++ {
		sum.WriteString(Verse(i))
		if i != end { sum.WriteString("\n\n") }
	}
	return sum.String()
}

func Song() string { return Verses(1, 8) }
