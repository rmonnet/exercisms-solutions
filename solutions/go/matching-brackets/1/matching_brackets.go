package brackets

// Stack provides a minimum implementation of a stack for this exercise.
type stack struct {
    elements []rune
}

func (s *stack) push(r rune) {
    s.elements = append(s.elements, r)
}

func (s *stack) pop() (rune, bool) {
    if len(s.elements) == 0 {
        return 0, false
    }
    n := len(s.elements) - 1
    res := s.elements[n]
    s.elements = s.elements[:n]
    return res, true
}

var openBrackets = map[rune]rune {']': '[', ')': '(', '}': '{'}

func Bracket(input string) bool {
	st := stack{}
    for _, letter := range input {
        switch letter {
        case '[', '{', '(':
            st.push(letter)
        case ']', '}', ')':
            openBracket, ok := st.pop()
            if !ok || openBracket != openBrackets[letter] {
                return false
            }
        }
    }
    // The bracket stack should be empty at this point.
    _, ok := st.pop()
    return !ok
}
