package thefarm

import (
	"errors"
	"fmt"
)

type InvalidCowsError struct {
	cows int;
	msg string
}

func (e InvalidCowsError) Error() string {
	return fmt.Sprintf("%d cows are invalid: %s", e.cows, e.msg)
}

func DivideFood(f FodderCalculator, cows int) (float64, error) {
	amount, err := f.FodderAmount(cows)
	if err != nil { return 0.0, err }

	factor, err := f.FatteningFactor()
	if err != nil { return 0.0, err }

	return amount / float64(cows) * factor, nil
}

func ValidateInputAndDivideFood(f FodderCalculator, cows int) (float64, error) {
	if cows <= 0 { return 0.0, errors.New("invalid number of cows") }
	return DivideFood(f, cows)
}

func ValidateNumberOfCows(cows int) error {
	switch {
	case cows < 0:
		return &InvalidCowsError{cows: cows, msg: "there are no negative cows"}
	case cows == 0:
		return &InvalidCowsError{cows: cows, msg: "no cows don't need food"}
	default:
		return nil
	}
}
