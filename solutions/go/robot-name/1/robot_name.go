package robotname

import (
    "math/rand"
    "fmt"
    "errors"
)

const numPossibleNames = 26 * 26 * 10 * 10 * 10

// Define the Robot type here.
type Robot struct {
    name string
}

var usedNames = make(map[string]struct{})

func newName() (string, error) {
    if len(usedNames) >= numPossibleNames {
        return "", errors.New("List of possible names exhausted")
    }
    // If there is at least one name available, we should be
    // able to find it, even if we have to loop for a very long time, so
    // this is guaranted not to be an infinite loop.
    for {
     	r1 := 'A' + int32(rand.Intn(26))
        r2 := 'A' + int32(rand.Intn(26))
        r3 := '0' + int32(rand.Intn(10))
        r4 := '0' + int32(rand.Intn(10))
        r5 := '0' + int32(rand.Intn(10))
        name := fmt.Sprintf("%c%c%c%c%c", r1, r2, r3, r4, r5)
        if _, ok := usedNames[name]; !ok {
            usedNames[name] = struct{}{}
            return name, nil
        }
    }
}

func (r *Robot) Name() (string, error) {
	if r.name == "" {
        name, err := newName()
        if err != nil {
            return "", err
        }
        r.name = name
    }
    return r.name, nil
}

func (r *Robot) Reset() {
    name, err := newName()
    // If no new name is available, we may as well keep out current one.
    if err == nil {
        r.name = name
    }
}
