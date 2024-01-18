package prime

import "errors"
import "math"

func isPrime(number int) bool {
	for i := 2; i <= int(math.Sqrt(float64(number))); i++ {
		if number % i == 0 { return false }
	}
	return true
}

func Nth(index int) (int, error) {
	if index < 1 { return 0, errors.New("Invalid input.") }

	n, count := 2, 0
	for {
		if isPrime(n) {
			count++
			if count == index { return n, nil }
		}
		n++
	}
}
