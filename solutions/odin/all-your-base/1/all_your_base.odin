package all_your_base

import "core:slice"
Error :: enum {
	None,
	Invalid_Input_Digit,
	Input_Base_Too_Small,
	Output_Base_Too_Small,
	Unimplemented,
}

rebase :: proc(input_base: int, digits: []int, output_base: int) -> ([]int, Error) {

	if input_base < 2 { return nil, .Input_Base_Too_Small }
	if output_base < 2 { return nil, .Output_Base_Too_Small }

	// Rebuild the number in input base.
	value := 0
	for digit in digits {
		if digit < 0 || digit >= input_base { return nil, .Invalid_Input_Digit }
		value = value * input_base + digit
	}

	// No deconstruct the value in output base
	output_digits: [dynamic]int
	for value > 0 {
		append(&output_digits, value % output_base)
		value /= output_base
	}
	if len(output_digits) == 0 {
		append(&output_digits, 0)
	}
	slice.reverse(output_digits[:])
	return output_digits[:], .None
}
