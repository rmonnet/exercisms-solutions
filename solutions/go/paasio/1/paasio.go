package paasio

// Based on the test suite, WriteCounter and ReadCounter
// must support concurrent operations.

import (
    "io"
    "sync"
)

type writeCounter struct {
    writer io.Writer
    nWriteBytes int64
    nWriteOps int
    muWrite sync.Mutex
}

type readCounter struct {
    reader io.Reader
    nReadBytes int64
    nReadOps int
    muRead sync.Mutex
}

type readWriteCounter struct {
    WriteCounter
    ReadCounter
}

func NewWriteCounter(writer io.Writer) WriteCounter {
	return &writeCounter{writer: writer}
}

func NewReadCounter(reader io.Reader) ReadCounter {
	return &readCounter{reader: reader}
}

func NewReadWriteCounter(readwriter io.ReadWriter) ReadWriteCounter {
	return &readWriteCounter{ReadCounter: NewReadCounter(readwriter),
                             WriteCounter: NewWriteCounter(readwriter)}
}

func (rc *readCounter) Read(p []byte) (int, error) {
    rc.muRead.Lock()
    defer rc.muRead.Unlock()
	nread, err := rc.reader.Read(p)
    rc.nReadBytes += int64(nread)
    rc.nReadOps++
    return nread, err
}

func (rc *readCounter) ReadCount() (int64, int) {
    rc.muRead.Lock()
    defer rc.muRead.Unlock()
	return rc.nReadBytes, rc.nReadOps
}

func (wc *writeCounter) Write(p []byte) (int, error) {
    wc.muWrite.Lock()
    defer wc.muWrite.Unlock()
	nwrite, err := wc.writer.Write(p)
    wc.nWriteBytes += int64(nwrite)
    wc.nWriteOps++
    return nwrite, err
}

func (wc *writeCounter) WriteCount() (int64, int) {
    wc.muWrite.Lock()
    defer wc.muWrite.Unlock()
	return wc.nWriteBytes, wc.nWriteOps
}
