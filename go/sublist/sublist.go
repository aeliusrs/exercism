package sublist

// Relation type is defined in relations.go file.
func areEqual(l1, l2 []int) bool {
	if len(l1) != len(l2) { return false }

	for i := range l1 {
		if l1[i] != l2[i] { return false }
	}
	return true
}

func isSuperlist(l1, l2 []int) bool {
	if len(l1) < len(l2) { return false }

	for i := 0; i <= len(l1)-len(l2); i++ {
		if areEqual(l1[i:i+len(l2)], l2) {
			return true
		}
	}
	return false
}

func Sublist(l1, l2 []int) Relation {
	eq := areEqual(l1, l2)
	sup := isSuperlist(l1, l2)
	sub := isSuperlist(l2, l1)

	switch {
		case len(l1) == len(l2) && eq: return RelationEqual
		case !eq && sub: return RelationSublist
		case !eq && sup: return RelationSuperlist
		default: return RelationUnequal
	}
	
}
