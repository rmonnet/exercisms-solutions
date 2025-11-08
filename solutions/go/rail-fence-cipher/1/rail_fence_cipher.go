package railfence

type fenceIndex struct {
    dir int
    idx int
    max int
}

func NewFenceIndex(rails int) *fenceIndex {
    return &fenceIndex{idx: 0, dir: 1, max: rails-1}
}

func (f *fenceIndex) next() {
    f.idx += f.dir
    if f.idx == 0 || f.idx == f.max {
        f.dir *= -1
    }
}

func Encode(message string, rails int) string {
	encodedLetters := make([][]byte, rails)
    f := NewFenceIndex(rails)
    for i := 0; i < len(message); i++ {
        encodedLetters[f.idx] = append(encodedLetters[f.idx], message[i])
        f.next()
    }
    res := ""
    for _, line := range encodedLetters {
        res += string(line)
    }
    return res
}

func Decode(message string, rails int) string {
	encodedLetters := make([][]byte, rails)
    ncols := len(message)
    for r := 0; r < rails; r++ {
        encodedLetters[r] = make([]byte, ncols)
    }
    // Mark the spots where the encoded letters go.
    f := NewFenceIndex(rails)
    for c := 0; c < len(message); c++ {
        encodedLetters[f.idx][c] = '?'
        f.next()
    }
    // Write the coded message in the '?' slots.
    l := 0
    for i := 0; i < rails; i++ {
        for j := 0; j < ncols; j++ {
            if encodedLetters[i][j] == '?' {
                encodedLetters[i][j] = message[l]
                l++
            }
        }
    }
    // Now read the message back
    res := make([]byte, 0, ncols)
    f = NewFenceIndex(rails)
    for c := 0; c < len(message); c++ {
        res = append(res, encodedLetters[f.idx][c])
        f.next()
    }
    return string(res)
}
