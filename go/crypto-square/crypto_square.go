package cryptosquare

import "strings"
import "math"
import "unicode"

func format(pt string) (string, int) {
	var ret strings.Builder
	
	for _, c := range strings.ToLower(pt) {
		if unicode.IsLetter(c) || unicode.IsDigit(c) {
			ret.WriteRune(c)
		}
	}

	length := len(ret.String())
	if length == 0 {
		return ret.String(), 1
	}

	grp := int(math.Ceil(math.Sqrt(float64(length))))
	if grp * grp < length { grp++ }

	return ret.String(), grp
}

func groupBy(ft string, grp int) []string {
	ret := []string{}

	for i := 0; i < len(ft); i += grp {
		end := i + grp
		if end > len(ft) {
			end = len(ft)
		}
		ret = append(ret, ft[i:end])
	}
	return ret
}

func Encode(pt string) string {
	ft, grp := format(pt)
	lst := groupBy(ft, grp)

	var ret strings.Builder

	for i := 0; i < grp; i++ {
		for _, str := range lst {
			if i < len(str) {
				ret.WriteByte(str[i])
			} else {
				ret.WriteByte(' ')
			}
		}
		if i < grp - 1 { ret.WriteByte(' ') }
	}
	return ret.String()
}
