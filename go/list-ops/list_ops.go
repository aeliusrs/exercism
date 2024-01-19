package listops

type IntList []int

func (s IntList) Length() (sum int) { for range s { sum++ }; return }

func (s IntList) Foldl(fn func(int, int) int, initial int) (acc int) {
	acc = initial
	for _, v := range s { acc = fn(acc, v) }; return
}

func (s IntList) Foldr(fn func(int, int) int, initial int) (acc int) {
	acc = initial
	for i := len(s) - 1; i >= 0; i-- { acc = fn(s[i], acc) }; return
}

func (s IntList) Append(lst IntList) IntList {
	acc := make(IntList, len(s) + len(lst))
	copy(acc, s); copy(acc[len(s):], lst)
	return acc
}

func (s IntList) Reverse() IntList {
	acc := make(IntList, len(s))

	for i, j := 0, len(s) - 1; j >= 0; i, j = i + 1, j - 1 { acc[i] = s[j] }
	return acc
}

func (s IntList) Filter(fn func(int) bool) IntList {
	acc := IntList{}

	for _, v := range s {
		if fn(v) { acc = acc.Append(IntList{v}) }
	}
	return acc
}

func (s IntList) Map(fn func(int) int) IntList {
	acc := make(IntList, len(s))
	for i, v := range s { acc[i] = fn(v) }; return acc
}

func (s IntList) Concat(lists []IntList) IntList {
	acc := IntList{}.Append(s)
	for _, lst := range lists { acc = acc.Append(lst) }; return acc
}
