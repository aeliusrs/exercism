package allyourbase

import "errors"

const (
	ErrInputBase = "input base must be >= 2"
	ErrOutputBase = "output base must be >= 2"
	ErrInvalidDigit = "all digits must satisfy 0 <= d < input base"
)

func ConvertToBase(inputBase int, inputDigits []int, outputBase int) ([]int, error) {
	if inputBase < 2 { return nil, errors.New(ErrInputBase) }
	if outputBase < 2 { return nil, errors.New(ErrOutputBase) }

	sum := 0
	for _, d := range inputDigits {
		if d < 0 || d >= inputBase {
			return nil, errors.New(ErrInvalidDigit)
		}
		sum = (sum * inputBase) + d
	}
	if sum == 0 { return []int{0}, nil }

	var acc []int
	for ; sum > 0; sum /= outputBase {
		acc = append([]int{sum % outputBase}, acc...)
	}

	return acc, nil
}
