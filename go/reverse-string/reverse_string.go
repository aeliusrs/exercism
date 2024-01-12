package reverse

func Reverse(input string) string {
	runes := []rune(input)
	length := len(runes)
	rev := make([]rune, length)

	for i, j := 0, length-1; i < length; i, j = i+1, j-1 {
        rev[i] = runes[j]
    }
	return string(rev)
}
