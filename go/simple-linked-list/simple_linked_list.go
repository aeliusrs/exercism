package linkedlist

import "errors"

// Define the List and Element types here.
type List struct {
	head *Element
	size int
}

type Element struct {
	data int
	next *Element
}

func New(elements []int) *List {
	list := &List{}
	for i := range elements {
		list.Push(elements[i])
	}
	return list
}

func (l *List) Size() int { return l.size }

func (l *List) Push(element int) {
	l.head = &Element{element, l.head}
	l.size++
}

func (l *List) Pop() (int, error) {
	if l.size < 1 { return 0, errors.New("List is empty") }

	data := l.head.data
	node := l.head
	l.head = node.next
	node.next = nil // to remove memory leak
	l.size--
	return data, nil
}

func (l *List) Array() []int {
	acc := make([]int, l.size)

	i := l.size - 1
	for node := l.head; node != nil; node = node.next {
		acc[i] = node.data
		i--
	}
	return acc
}

func (l *List) Reverse() *List {
	acc := make([]int, l.size)

	i := 0
	for node := l.head; node != nil; node = node.next {
		acc[i] = node.data
		i++
	}
	return New(acc)

}
