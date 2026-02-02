package bob

import "core:strings"

response :: proc(input: string) -> string {
    response := "Whatever."
    trimmed_input := strings.trim(input, " \n\r\t")
    switch {
    case is_silence(trimmed_input):
        response = "Fine. Be that way!"
    case is_yelling(trimmed_input) && is_question(trimmed_input):
        response = "Calm down, I know what I'm doing!"
	case is_question(trimmed_input):
        response = "Sure."
    case is_yelling(trimmed_input):
        response = "Whoa, chill out!"
    }
    return response
}

is_question :: proc(input: string) -> bool {
    return strings.has_suffix(input, "?")
}

is_yelling :: proc(input: string) -> bool {
    return input == strings.to_upper(input) && input != strings.to_lower(input)
}

is_silence :: proc(input: string) -> bool {
    return input == ""
}