package twelve

import "fmt"
import "strings"

const template = "On the %s day of Christmas my true love gave to me: %s."

var num = [12]string{
	"first",
	"second",
	"third",
	"fourth",
	"fifth",
	"sixth",
	"seventh",
	"eighth",
	"ninth",
	"tenth",
	"eleventh",
	"twelfth",
}

var list = [12]string{
	"a Partridge in a Pear Tree",
	"two Turtle Doves",
	"three French Hens",
	"four Calling Birds",
	"five Gold Rings",
	"six Geese-a-Laying",
	"seven Swans-a-Swimming",
	"eight Maids-a-Milking",
	"nine Ladies Dancing",
	"ten Lords-a-Leaping",
	"eleven Pipers Piping",
	"twelve Drummers Drumming",
}

func getList(n int) string {
	var sum strings.Builder
	gifts := list[:n]

	for i := len(gifts) - 1; i >= 0; i-- {
		if i == 0 {
			sum.WriteString("and ")
			sum.WriteString(gifts[i])
		} else {
			sum.WriteString(gifts[i])
			sum.WriteString(", ")
		}
	}
	return sum.String()
}

func Verse(n int) string {
	var gifts string

	if n == 1 { gifts = list[0] } else { gifts = getList(n) }
	return fmt.Sprintf(template, num[n - 1], gifts)
}

func Song() string {
	var sum strings.Builder

	for i := 1; i < 13; i++ {
		sum.WriteString(Verse(i))
		if i < 12 { sum.WriteString("\n") }
	}
	return sum.String()
}
