package lsproduct

import "sort"
import "errors"
import "unicode"

func isValid (digits string) bool {
	for _, c := range digits {
		if !unicode.IsDigit(c) { return false }
		continue
	}
	return true
}

func product(digits string) (sum int64) {
	for _, c := range digits {
		if c == '0' { return 0 }
		if sum == 0 {
			sum += int64(c - '0')
		} else {
			sum *= int64(c - '0')
		}
	}
	return
}

func pick(digits []int64) (ret int64) {
	sort.Slice(digits, func(i, j int) bool {
		return digits[i] > digits[j]
	})
	ret = digits[0]
	return
}

func LargestSeriesProduct(digits string, span int) (int64, error) {
	acc := []int64{}

	if span < 0 || span > len(digits) || !isValid(digits) {
		return -1, errors.New("invalid span value")
	}

	for i := 0; i < len(digits); i++ {

		cut := digits[i:]
		if len(cut) < span { break }
		acc = append(acc, product(cut[:span]))
	}
	return pick(acc), nil
}
