package stringset

import "strings"

type Set map[string]bool //map can not have duplicate

func New() Set { return Set{} }

func NewFromSlice(l []string) (acc Set) {
	acc = New()
	for _, v := range l { acc[v] = true }; return
}

func (s Set) String() string {
	var acc strings.Builder //more effective than "+" op on string type
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

func (s Set) Has(elem string) bool { return s[elem] }

func (s Set) Add(elem string) { s[elem] = true } //if exist remain unchanged

func Subset(s1, s2 Set) bool {
	for k, _ := range s1 { if !s2[k] { return false } }
	return true
}

func Disjoint(s1, s2 Set) bool {
	for k := range s1 { if s2[k] { return false } }
	return true
}

func Equal(s1, s2 Set) bool {
	if len(s1) != len(s2) { return false }
	return Subset(s1, s2) && Subset(s2, s1)
}

func Intersection(s1, s2 Set) Set {
	result := New()

	for k, _ := range s1 {
		if s2[k] { result.Add(k) }
	}
	return result
}

func Difference(s1, s2 Set) Set {
	result := New()

	for k, _ := range s1 {
		if !s2[k] { result.Add(k) }
	}
	return result
}

func Union(s1, s2 Set) Set {
	result := New()

	for k, _ := range s1 { result.Add(k) }
	for k, _ := range s2 { result.Add(k) }
	return result
}
