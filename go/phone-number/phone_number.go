package phonenumber

import "fmt"
import "strings"
import "unicode"
import "errors"


func filter(phoneNumber string) string {
	var num strings.Builder

	num.Grow(11)
	for _, c := range phoneNumber {
		if unicode.IsDigit(c) { num.WriteRune(c) }
	}
	return num.String()
}

func Number(phoneNumber string) (string, error) {
	num := filter(phoneNumber)

	if num[0] == '1' && len(num) == 11 {
		num = num[1:]
	}

	switch {
		case len(num) > 10 || len(num) < 10: return "", errors.New("invalid num")
		case num[0] < '2': return "", errors.New("invalid code")
		case num[3] < '2': return "", errors.New("invalid exchange")
		default: return num, nil
	}
}

func AreaCode(phoneNumber string) (string, error) {
	num, err := Number(phoneNumber)

	if err != nil { return "", err }
	return num[:3], nil
}

func Format(phoneNumber string) (string, error) {

	num, err := Number(phoneNumber)

	if err != nil { return "", err }
	return fmt.Sprintf("(%s) %s-%s", num[:3], num[3:6], num[6:]), nil
}
