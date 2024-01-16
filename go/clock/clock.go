package clock

import "fmt"

// Define the Clock type here.
type Clock struct{
	h int
	m int
}

func New(h, m int) Clock {
	total := (h * 60 + m) % (24 * 60)

	if total < 0 { total += 24 * 60 }
	return Clock{total / 60, total % 60}
}

func (c Clock) Add(m int) Clock {
	total := c.h * 60 + (c.m + m)
	return New(total / 60, total % 60)
}

func (c Clock) Subtract(m int) Clock {
	total := c.h * 60 + (c.m - m)
	return New(total / 60, total % 60)
}

func (c Clock) String() string { return fmt.Sprintf("%02d:%02d", c.h, c.m) }
