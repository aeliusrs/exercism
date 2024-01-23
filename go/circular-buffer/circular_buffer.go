package circular

import "errors"

type Buffer struct {
	buffer []byte
	capacity int
}

func NewBuffer(size int) *Buffer {
	return &Buffer{ buffer: []byte{}, capacity: size, }
}

func (b *Buffer) Reset() { b.buffer = b.buffer[:0] }

func (b *Buffer) ReadByte() (byte, error) {
	if len(b.buffer) <= 0 { return 0, errors.New("buffer is empty !") }

	val := b.buffer[0]
	b.buffer = b.buffer[1:]
	return val, nil
}

func (b *Buffer) WriteByte(c byte) error {
	if len(b.buffer) >= b.capacity { return errors.New("buffer is full !") }

	b.buffer = append(b.buffer, c)
	return nil
}

func (b *Buffer) Overwrite(c byte) {
	if len(b.buffer) >= b.capacity { b.buffer = b.buffer[1:] }

	b.buffer = append(b.buffer, c)
}
