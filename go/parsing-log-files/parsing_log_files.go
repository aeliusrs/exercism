package parsinglogfiles

import (
	"regexp"
	"errors"
)

func IsValidLine(text string) bool {
	pattern := `^\[(TRC|DBG|INF|WRN|ERR|FTL)\]`
	match, _ := regexp.MatchString(pattern, text)
	return match
}

func SplitLogLine(text string) []string {
	re, err := regexp.Compile(`<[-~=*]*>`)

	if err != nil { errors.New("wrong pattern") }
	return re.Split(text, -1)
}

func CountQuotedPasswords(lines []string) (sum int) {
	re, err := regexp.Compile(`(?i)".*password.*"`)

	if err != nil { errors.New("wrong pattern") }

	for _, line := range lines {
		if re.MatchString(line) { sum++ }
	}
	return
}

func RemoveEndOfLineText(text string) string {
	re, err := regexp.Compile(`end-of-line\d*`)

	if err != nil { errors.New("wrong pattern") }
    return re.ReplaceAllString(text, "")
}

func TagWithUserName(lines []string) []string {
	re, err := regexp.Compile(`User\s+(\w*)`)

	if err != nil { errors.New("wrong pattern") }

	for i, line := range lines {
		submatches := re.FindStringSubmatch(line)
		if submatches != nil {
			lines[i] = "[USR] "+submatches[1]+" "+line
		}
	}
	return lines
}
