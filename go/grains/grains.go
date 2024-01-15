package grains

import "errors"

func Square(number int) (uint64, error) {
	if number <=0 || number > 64 {
		return 0, errors.New("wrong case number")
	}

	return 1 << (number - 1), nil
}

func Total() (sum uint64) {
	for i := 0; i <= 64; i++ {
		x, _ := Square(i)
		sum += x
	}
	return
}
