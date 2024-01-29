package brackets

func Bracket(input string) bool {
	var acc []rune

	for _, c := range input {
		switch c {
			// open cases
			case '(', '[', '{': acc = append(acc, c)
			// closing case
		case ')':
			if len(acc) == 0 || acc[len(acc) - 1] != '(' { return false }
			acc = acc[:len(acc) - 1]
		case ']':
			if len(acc) == 0 || acc[len(acc) - 1] != '[' { return false }
			acc = acc[:len(acc) - 1]
		case '}':
			if len(acc) == 0 || acc[len(acc) - 1] != '{' { return false }
			acc = acc[:len(acc) - 1]
			// ignore other char case
			default: continue
		}
	}

	return len(acc) == 0
}
/* Basically, we loop over the string and collect opening elements in the acc.

 For every closing brackets meet we do the following:
   - is the opening bracket present as the last elements of the acc ?
     if not that mean there is a mismatch or a wrong placement

   - if the accumulator is empty, or the first element is not his opening
     bracket, that mean there is a mismatch or wrong placement
for any other character we just ignore.

Note, using append(acc, element) and doing len(acc) -  1 operation,
is faster than to preprend doing append([]rune{element}, acc...) and
using acc[0] acc[1:]... 
*/

