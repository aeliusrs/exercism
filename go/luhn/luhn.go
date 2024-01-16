package luhn

import "strings"
import "strconv"

func Valid(id string) bool {
id = strings.ReplaceAll(id, " ", "")
	var length int = len(id)
	var sum int = 0
	var alt bool = false

	if length < 1 || id == "0" { return false }

	for i := length - 1; i >= 0; i-- {
		n, err := strconv.Atoi(string(id[i]))

		if err != nil { return false }

		if alt {
			n = (n * 2)
			if n > 9 { n -= 9 }
		}

		sum += n
		alt = !alt
	}

	return (sum % 10) == 0
}
