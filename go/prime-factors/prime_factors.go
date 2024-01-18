package prime

func Factors(n int64) (sum []int64) {
	var factor int64 = 2

	for n != 1 {
		if n % factor == 0 {
			sum = append(sum, factor)
			n /= factor
			factor = 2
		} else {
			factor++
		}
	}
	return
}
