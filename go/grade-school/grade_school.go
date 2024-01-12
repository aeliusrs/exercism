package school

import "sort"

type School map[int][]string

type Grade struct {
	score int
	students []string
}


func New() *School { return &School{} }

func (s *School) Add(student string, grade int) {
	k, _ := (*s)[grade]
	(*s)[grade] = append(k, student)
}

func (s *School) Grade(level int) []string { return (*s)[level] }

func (s *School) Enrollment() (enroll []Grade) {
	var keys []int

	for k := range *s { keys = append(keys, k) }
	sort.Ints(keys)

	for _, key := range keys {
		names, ok := (*s)[key]
		if ok { sort.Strings(names) }

		entry := Grade{
			score: key,
			students: names,
		}

		enroll = append(enroll, entry)
	}
	return
}
