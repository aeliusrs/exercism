package reverse

func Reverse(input string) (rev string) {
	for _, c := range input {
		rev = string(c) + rev
	}
	return
}
