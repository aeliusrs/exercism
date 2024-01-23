package stringset

import "strings"

type Set map[string]bool

func New() Set { return make(Set) }

func NewFromSlice(l []string) (acc Set) {
	acc = New()
	for _, v := range l { acc[v] = true }; return
}

func (s Set) String() string {
	var acc strings.Builder
	var length int = len(s) - 1
	var i int = 0

	acc.WriteString("{")
	for k, _ := range s {
		acc.WriteRune('"')
		acc.WriteString(k)
		acc.WriteRune('"')
		if i < length {
			acc.WriteString(", ")
		}
		i++
	}
	acc.WriteString("}")
	return acc.String()
}

func (s Set) IsEmpty() bool { return len(s) == 0 }

func (s Set) Has(elem string) bool { _, ok := s[elem]; return ok }

func (s Set) Add(elem string) { if _, ok := s[elem]; !ok { s[elem] = true } }

func Subset(s1, s2 Set) bool {
	for k, _ := range s1 { if !s2.Has(k) { return false } }
	return true
}

func Disjoint(s1, s2 Set) bool {
	for k := range s1 { if s2.Has(k) { return false } }
	return true
}

func Equal(s1, s2 Set) bool {
	if len(s1) != len(s2) { return false }

	for k, _ := range s1 {
		if !s2.Has(k) { return false }
	}
	return true
}

func Intersection(s1, s2 Set) Set {
	result := New()

	for k, _ := range s1 {
		if s2.Has(k) { result.Add(k) }
	}
	return result
}

func Difference(s1, s2 Set) Set {
	result := New()

	for k, _ := range s1 {
		if !s2.Has(k) { result.Add(k) }
	}
	return result
}

func Union(s1, s2 Set) Set {
	result := New()

	for k, _ := range s1 { result.Add(k) }
	for k, _ := range s2 { result.Add(k) }
	return result
}
