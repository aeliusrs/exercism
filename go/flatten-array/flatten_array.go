package flatten

// ---
// []interface{} is a general slice that can contain different type or struct

// ---
// becare full with return init such as (acc []interface{}) the created
// acc is not initialize properly to pass the test

func Flatten(nested interface{}) []interface{} {
	acc := make([]interface{}, 0)

	switch items := nested.(type) {
		case []interface{}:
			for _, item := range items {
				acc = append(acc, Flatten(item)...)
			}
		case interface{}: acc = append(acc, items)
	}
	return acc
}
