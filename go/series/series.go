package series

func All(n int, s string) []string {
	sum := make([]string, 0, (len(s) - n + 1)) //optimize append operation

	for i := 0; i < len(s); i++ {
		if len(s[i:]) < n { break }
		sum = append(sum, s[i:][:n])
	}
	return sum
}

func UnsafeFirst(n int, s string) string { return s[:n] }

