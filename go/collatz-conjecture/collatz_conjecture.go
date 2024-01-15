package collatzconjecture

import "errors"

func CollatzConjecture(n int) (step int, err error) {
	if n < 1 { return 0, errors.New("invalid given n") }
	for n > 1{
		if (n & 1) == 0 { n = n >> 1 } else { n = (n << 1) + (n + 1) }
		step++
	}
	return step, nil
}
