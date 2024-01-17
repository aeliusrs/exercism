package bottlesong

import "fmt"
import "strings"

const (
	line1 = "%s green bottle%s hanging on the wall,"
	line2 = "And if one green bottle should accidentally fall,"
    line3 = "There'll be %s green bottle%s hanging on the wall."
)

var conversion = map[int]string{
		10: "Ten",
		9: "Nine",
		8: "Eight",
		7: "Seven",
		6: "Six",
		5: "Five",
		4: "Four",
		3: "Three",
		2: "Two",
		1: "One",
		0: "No",
	}

func getS(n int) string { if n != 1 { return "s" } else { return "" } }

func getNum(n int) string { return conversion[n] }

func verse(n int) []string {
	v1 := fmt.Sprintf(line1, getNum(n), getS(n))
	v3 := fmt.Sprintf(line3, strings.ToLower(getNum(n - 1)), getS(n - 1))

	return []string{"",v1, v1, line2, v3}
}

func Recite(startBottles, takeDown int) (recite []string) {

	for i := startBottles; i > (startBottles - takeDown); i-- {
		recite = append(recite, verse(i)...)
	}
	return recite[1:]
}
