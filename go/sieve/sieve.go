package sieve

import "math"

func Sieve(limit int) (primes []int) {
	table := make([]bool, limit + 1)

	for p := 2; p <= int(math.Sqrt(float64(limit))); p++ {
		if table[p] == false {
			for i := p * p; i <= limit; i += p {
				table[i] = true
			}
		}
	}

	for p := 2; p <= limit; p++ {
		if table[p] == false {
			primes = append(primes, p)
		}
	}
	return
}
