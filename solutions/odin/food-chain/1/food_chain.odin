package food_chain

import "core:strings"
recite :: proc(start, end: int) -> string {

	buf := strings.builder_make()
	for i in start ..= end {
		if i > start {
			strings.write_string(&buf, "\n\n")
		}
		verse(i, &buf)
	}
	return strings.to_string(buf)
}

verse :: proc(n: int, buf: ^strings.Builder) {

	if n < 0 || n > len(animals) { return }

	strings.write_string(buf, "I know an old lady who swallowed a ")
	strings.write_string(buf, animals[n - 1])
	strings.write_string(buf, ".\n")

	if n == len(animals) {
		strings.write_string(buf, "She's dead, of course!")
		return
	}

	if n > 1 {
		strings.write_string(buf, second_lines[n - 2])
	}
	for i := n - 1; i > 0; i -= 1 {
		strings.write_string(buf, "She swallowed the ")
		strings.write_string(buf, animals[i])
		strings.write_string(buf, " to catch the ")
		strings.write_string(buf, animals[i - 1])
		if i == 2 {
			strings.write_string(buf, " that wriggled and jiggled and tickled inside her")
		}
		strings.write_string(buf, ".\n")
	}
	strings.write_string(buf, "I don't know why she swallowed the fly. Perhaps she'll die.")
}

animals := [?]string{"fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse"}

second_lines := [?]string {
	"It wriggled and jiggled and tickled inside her.\n",
	"How absurd to swallow a bird!\n",
	"Imagine that, to swallow a cat!\n",
	"What a hog, to swallow a dog!\n",
	"Just opened her throat and swallowed a goat!\n",
	"I don't know how she swallowed a cow!\n",
}
