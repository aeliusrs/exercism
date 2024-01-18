package strain
// You will need typed parameters (aka "Generics") to solve this exercise.
// They are not part of the Exercism syllabus yet but you can learn about
// them here: https://go.dev/tour/generics/1


func filter[T any](input []T, strain func(T) bool, valid bool) []T {
	acc := make([]T, 0, len(input))

	for _, value := range input {
		if strain(value) == valid { acc = append(acc, value) }
	}
	return acc
}

func Keep[T any](input []T, strain func(T) bool) []T {
	return filter(input, strain, true)
}

func Discard[T any](input []T, strain func(T) bool) []T {
	return filter(input, strain, false)
}
