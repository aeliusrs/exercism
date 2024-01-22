package transpose

func getMaxSize(input []string) (size int) {
	for _, item := range input {
		if len(item) > size { size = len(item) }
	}
	return
}

func Transpose(input []string) []string {
	max := getMaxSize(input)
	acc := make([]string, max)

	for i, row := range input {
		max = getMaxSize(input[i:])

		for j, ch := range row { acc[j] += string(ch) }
		for k := len(row); k < max;  k++ { acc[k] += " " }
	}
	return acc
}
