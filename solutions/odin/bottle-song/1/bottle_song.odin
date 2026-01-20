package bottle_song

import "core:fmt"
import "core:strings"
recite :: proc(start_bottles, take_down: int) -> []string {

	verses: [dynamic]string
	for i in 0 ..< take_down {
		if i > 0 {
			append(&verses, "")
		}
		recite_verse(start_bottles - i, &verses)
	}
	return verses[:]
}

recite_verse :: proc(verse: int, buffer: ^[dynamic]string) {

	number_uc := numbers_uc[verse]
	plural := "s" if verse != 1 else ""
	append(buffer, fmt.aprintf("%s green bottle%s hanging on the wall,", number_uc, plural))
	append(buffer, fmt.aprintf("%s green bottle%s hanging on the wall,", number_uc, plural))

	// We technically don't need aprintf() here but it makes memory management simpler.
	// This way all lines in buffer are dynamically allocated.
	append(buffer, fmt.aprintf("And if one green bottle should accidentally fall,"))

	number := numbers[verse - 1]
	plural = "s" if verse != 2 else ""
	append(
		buffer,
		fmt.aprintf("There'll be %s green bottle%s hanging on the wall.", number, plural),
	)
}

numbers_uc := [?]string {
	"No",
	"One",
	"Two",
	"Three",
	"Four",
	"Five",
	"Six",
	"Seven",
	"Eight",
	"Nine",
	"Ten",
}

numbers := [?]string {
	"no",
	"one",
	"two",
	"three",
	"four",
	"five",
	"six",
	"seven",
	"eight",
	"nine",
	"ten",
}
