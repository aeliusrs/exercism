package wordy

import "strconv"
import "regexp"

func eval(stk, ops []string) (int, bool) {
	if len(ops) != len(stk) - 1 { return 0, false }

	sum, _ := strconv.Atoi(stk[0])
	for i, op := range ops {
		n, _ := strconv.Atoi(stk[i + 1])
		switch op {
			case "plus": sum += n
			case "minus": sum -= n
			case "divided": sum /= n
			case "multiplied": sum *= n
		}
	}
	return sum, true
}

func Answer(question string) (int, bool) {
	inv, _ := regexp.MatchString(
		`What is -?\d+(?: (?:plus|minus|divided by|multiplied by) -?\d+)*\?`,
	question)

	if !inv { return 0, false }

	match := regexp.MustCompile(`(plus|minus|divided|multiplied)`)
	ops := match.FindAllString(question, -1)

	match = regexp.MustCompile(`-?\d+`)
	stk := match.FindAllString(question, -1)

	return eval(stk, ops)
}
