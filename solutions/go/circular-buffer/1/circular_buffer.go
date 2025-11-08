package circular

import "errors"

// Implement a circular buffer of bytes supporting both overflow-checked writes
// and unconditional, possibly overwriting, writes.
//
// We chose the provided API so that Buffer implements io.ByteReader
// and io.ByteWriter and can be used (size permitting) as a drop in
// replacement for anything using that interface.

// Define the Buffer type here.
type Buffer struct {
    elements []byte
    capa int
    size int
    front int
}

var ErrEmptyBuffer = errors.New("buffer is empty")

var ErrFullBuffer = errors.New("buffer is full")

func NewBuffer(size int) *Buffer {
	return &Buffer{elements: make([]byte, size), capa: size}
}

func (b *Buffer) ReadByte() (byte, error) {
	if b.size == 0 {
        return 0, ErrEmptyBuffer
    }
    res := b.elements[b.front]
    b.front = (b.front + 1) % b.capa
    b.size--
    return res, nil
}

func (b *Buffer) WriteByte(c byte) error {
	if b.size == b.capa {
        return ErrFullBuffer
    }
    index := (b.front + b.size) % b.capa
    b.elements[index] = c
    b.size++
    return nil
}

func (b *Buffer) Overwrite(c byte) {
	if b.size == b.capa {
        // Buffer is full, remove oldest value and add c.
        b.elements[b.front] = c
        b.front = (b.front + 1) % b.capa
    } else {
        // Buffer is not full, just add one byte.
        index := (b.front + b.size) % b.capa
    	b.elements[index] = c
    	b.size++
    }
}

func (b *Buffer) Reset() {
	b.front = 0
    b.size = 0
}
