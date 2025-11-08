package forth

import (
	"fmt"
	"regexp"
	"strconv"
	"strings"
)

// Forth is typically low-level and implement its own buffer, dictionary and virtual
// machine instruction set.
//
// Since we are using Go, we will make full use of the provided map, closures,
// and first order functions facilities it provides.

// Verbose, when set to true, makes the Forth interpreter log its input and output.
const verbose = false

// Instruction define a forth word, including the ones defined by the user.
type instruction func() error

// Stack represents the Forth stack where instructions take their arguments and post their
// result.
var stack []int

// Dictionary contains the definition of all the Forth words (including the built-in words).
var dictionary map[string]instruction

// NumberRe is the regular expression checking for integer numbers.
var numberRe = regexp.MustCompile(`^-?\d+$`)

// Forth takes a number of lines of input and returns the resulting stack
// or an error if the execution failed.
func Forth(input []string) ([]int, error) {
	if verbose {
		fmt.Printf("%q -> ", input)
	}
	initialize()
	for _, line := range input {
		// This Forth version is case insensitive.
		line = strings.ToLower(line)
		words := strings.Split(line, " ")
		err := interpret(words)
		if err != nil {
			wrappedError := fmt.Errorf("error: input '%s': %w", line, err)
			if verbose {
				fmt.Printf("%s\n", wrappedError.Error())
			}
			return nil, wrappedError
		}
	}
	if verbose {
		fmt.Printf("%s\n", dumpStack())
	}
	return stack, nil
}

// Initialize initializes the Forth interpreter.
// It clears the stack, the dictionary and define the built-in words.
func initialize() {

	// Clear the interpreter state.
	stack = []int{}
	dictionary = map[string]instruction{}

	// Define the built-in functions (except ":" and ";" which are hard-coded
	// in the interpreter).
	dictionary["+"] = func() error {
		if len(stack) < 2 {
			return fmt.Errorf("+ requires 2 stack elements: %s", dumpStack())
		}
		push(pop() + pop())
		return nil
	}
	dictionary["-"] = func() error {
		if len(stack) < 2 {
			return fmt.Errorf("- requires 2 stack elements: %s", dumpStack())
		}
		a, b := pop(), pop()
		push(b - a)
		return nil
	}
	dictionary["*"] = func() error {
		if len(stack) < 2 {
			return fmt.Errorf("* requires 2 stack elements: %s", dumpStack())
		}
		push(pop() * pop())
		return nil
	}
	dictionary["/"] = func() error {
		if len(stack) < 2 {
			return fmt.Errorf("/ requires 2 stack elements: %s", dumpStack())
		}
		if peek(0) == 0 {
			return fmt.Errorf("can't divide by 0: %s", dumpStack())
		}
		a, b := pop(), pop()
		push(b / a)
		return nil
	}
	dictionary["dup"] = func() error {
		if len(stack) < 1 {
			return fmt.Errorf("dup requires 1 stack element: %s", dumpStack())
		}
		push(peek(0))
		return nil
	}
	dictionary["drop"] = func() error {
		if len(stack) < 1 {
			return fmt.Errorf("drop requires 1 stack element: %s", dumpStack())
		}
		pop()
		return nil
	}
	dictionary["swap"] = func() error {
		if len(stack) < 2 {
			return fmt.Errorf("swap requires 2 stack elements: %s", dumpStack())
		}
		a, b := pop(), pop()
		push(a)
		push(b)
		return nil
	}
	dictionary["over"] = func() error {
		if len(stack) < 2 {
			return fmt.Errorf("over requires 2 stack elements: %s", dumpStack())
		}
		push(peek(1))
		return nil
	}
}

// Interpret executes the sets of provided words.
// If returns an error if it cannot interpret a word or an error occurs
// during a word execution.
func interpret(words []string) error {
	for i := 0; i < len(words); i++ {
		word := words[i]
		switch {
		case numberRe.MatchString(word):
			value, _ := strconv.Atoi(word)
			push(value)
		case word == ":":
			nextI, err := compile(i+1, words)
			if err != nil {
				return fmt.Errorf("compiling: %w", err)
			}
			// Skip ahead to the token after ';'
			i = nextI
		default:
			instr, ok := dictionary[word]
			if !ok {
				return fmt.Errorf("unknown word: %s", word)
			}
			err := instr()
			if err != nil {
				return err
			}
		}
	}
	return nil
}

// Pop pops the first value from the interpreter stack.
func pop() int {
	res := stack[len(stack)-1]
	stack = stack[:len(stack)-1]
	return res
}

// Peek peeks the nth value from the interpreter stack.
// 0 represents the top of the stack, 1 represents the next-to-top value, etc.
func peek(n int) int {
	return stack[len(stack)-1-n]
}

// Push pushes value on the interpreter stack.
func push(value int) {
	stack = append(stack, value)
}

// Compile compile the word coming next in the input.
// It returns the index in the input where the interpreter should
// resume or an error if compilation failed.
func compile(index int, words []string) (int, error) {
	// When we redefine a word, previous word definition using the old
	// definition will still work since they contain a reference to the old
	// instruction in their code. Words defined after this one, will lookup
	// and use the new definition.
	//
	// If compilation is successful, we build on the fly an instruction that
	// will execute the definition in order.
	//
	// Note that this implementation prevents us to implement the Forth word "forget".
	wordname := words[index]
	// For now doesn't allow redefinition of ":" and ";".
	if wordname == ":" || wordname == ";" {
		return 0, fmt.Errorf("not allowed to redefine %s", wordname)
	}
	// Not allowed to redefine numbers.
	if numberRe.MatchString(wordname) {
		return 0, fmt.Errorf("not allowed to redefine number %s", wordname)
	}
	endOfDef := false
	code := []instruction{}
defLoop:
	for i := index + 1; i < len(words); i++ {
		word := words[i]
		switch {
		case numberRe.MatchString(word):
			value, _ := strconv.Atoi(word)
			code = append(code, makeConstant(value))
		case word == ":":
			return 0, fmt.Errorf("found new definition embedded in definition for %s", wordname)
		case word == ";":
			endOfDef = true
			index = i + 1
			break defLoop
		default:
			instr, ok := dictionary[word]
			if !ok {
				return 0, fmt.Errorf("unknown word (%s) used in %s definition", word, wordname)
			}
			code = append(code, instr)
		}
	}
	if !endOfDef {
		return 0, fmt.Errorf("reached end of line before end of definition")
	}
	dictionary[wordname] = func() error {
		for _, instr := range code {
			err := instr()
			if err != nil {
				return fmt.Errorf("error executing %s: %w", wordname, err)
			}
		}
		return nil
	}
	return index, nil
}

// Make a constant defines a new instruction that pushes
// a specific constant on the stack.
// This is actually close to how low-level forth compiles numbers.
func makeConstant(n int) instruction {
	return func() error {
		push(n)
		return nil
	}
}

// DumpStack returns a representation of the content of the stack.
// This is used with verbose to log input and output to the interpreter.
func dumpStack() string {
	var out strings.Builder
	fmt.Fprint(&out, "(")
	for i, v := range stack {
		if i > 0 {
			fmt.Fprint(&out, " ")
		}
		fmt.Fprintf(&out, "%d", v)
	}
	fmt.Fprint(&out, ")")
	return out.String()
}
