package paasio

import "io"
import "sync"

type readCounter struct {
	ior          io.Reader
	counter
}

type writeCounter struct {
	iow           io.Writer
	counter
}

type readWriteCounter struct {
	WriteCounter
	ReadCounter
}

// Counter interface
type counter struct {
	lock      *sync.RWMutex
	bytes     int64
	op        int
}

func newCounter() counter { return counter{lock: new(sync.RWMutex)} }

func (c *counter) count(n int64) {
	c.lock.Lock()
	defer c.lock.Unlock()

	c.op++
	c.bytes += n
}

func (c *counter) get() (int64, int) {
	c.lock.RLock()

	defer c.lock.RUnlock()
	return c.bytes, c.op
}

// For the return of the function NewReadWriteCounter, you must also define a type that satisfies the ReadWriteCounter interface.

func NewWriteCounter(writer io.Writer) WriteCounter {
	return &writeCounter{ iow: writer, counter: newCounter() }
}

func NewReadCounter(reader io.Reader) ReadCounter {
	return &readCounter{ ior: reader, counter: newCounter() }
}

func NewReadWriteCounter(readwriter io.ReadWriter) ReadWriteCounter {
	return &readWriteCounter{
		NewWriteCounter(readwriter),
		NewReadCounter(readwriter),
	}
}

func (rc *readCounter) Read(p []byte) (int, error) {
	n, err := rc.ior.Read(p)

	rc.count(int64(n))
	return n, err
}


func (wc *writeCounter) Write(p []byte) (int, error) {
	n, err := wc.iow.Write(p)

	wc.count(int64(n))
	return n, err
}

func (rc *readCounter) ReadCount() (int64, int) { return rc.counter.get() }

func (wc *writeCounter) WriteCount() (int64, int) { return wc.counter.get() }
