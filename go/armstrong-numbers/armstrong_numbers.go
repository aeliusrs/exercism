package armstrong

import "math"

func getStep(n int) (step int) {
	for n > 0 {
		n /= 10
		step++
	}
	return
}

func IsNumber(n int) bool {
	var acc float64

	i := n
	step := getStep(n)
	for i > 0 {
		digit := float64(i % 10)
		i /= 10
		acc += math.Pow(digit, float64(step))
	}
	return int(acc) == n
}
