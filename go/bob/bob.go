// This is a "stub" file.  It's a little start on your solution.
// It's not a complete solution though; you have to write some code.

// Package bob should have a package comment that summarizes what it's about.
// https://golang.org/doc/effective_go.html#commentary
package bob

import "unicode"
import "strings"

func isYelling(remark string) bool {
	hasLetters := (strings.IndexFunc(remark, unicode.IsLetter) >= 0)
	isUpper := (strings.ToUpper(remark) == remark)
	return hasLetters && isUpper
}

func isQuestion(remark string) bool { return strings.HasSuffix(remark, "?") }

func isSilence(remark string) bool { return remark == "" }

func Hey(remark string) string {
	sanitized := strings.TrimSpace(remark)

	question := isQuestion(sanitized)
	yell := isYelling(sanitized)
	silence := isSilence(sanitized)

	switch {
		case silence : return "Fine. Be that way!"
		case yell && question: return "Calm down, I know what I'm doing!"
		case yell: return "Whoa, chill out!"
		case question: return "Sure."
		default: return "Whatever."
	}
}
