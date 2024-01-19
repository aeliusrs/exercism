package summultiples

func SumMultiples(limit int, divisors ...int) (sum int) {
	acc := make(map[int]bool)

	for _, divisor := range divisors {
		for i := 1; i < limit; i++ {
			if divisor > 0 && i % divisor == 0 && !acc[i] {
				acc[i] = true
				sum += i
			}
		}
	}
	return
}
