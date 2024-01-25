package house

import "strings"

var lines = []string{
	"the horse and the hound and the horn\nthat belonged to",
	"the farmer sowing his corn\nthat kept",
	"the rooster that crowed in the morn\nthat woke",
	"the priest all shaven and shorn\nthat married",
	"the man all tattered and torn\nthat kissed",
	"the maiden all forlorn\nthat milked",
	"the cow with the crumpled horn\nthat tossed",
	"the dog\nthat worried",
	"the cat\nthat killed",
	"the rat\nthat ate",
	"the malt\nthat lay in",
}

func Verse(v int) string {
	v = v - 1

	var verse strings.Builder

	verse.WriteString("This is ")
	for _, s := range lines[len(lines) - v:] {
		verse.WriteString(s)
		verse.WriteRune(' ')
	}
	verse.WriteString("the house that Jack built.")

	return verse.String()
}

func Song() string {
	var song strings.Builder

	for i := 1; i <= 12; i++ {
		song.WriteString(Verse(i))

		if i < 12 { song.WriteString("\n\n") }
	}
	return song.String()
}
