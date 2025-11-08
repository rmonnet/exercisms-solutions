package foodchain

import (
    "fmt"
    "strings"
)

var animals = []string{
    "fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse"}

var secondSentence = []string{
    "",
    "It wriggled and jiggled and tickled inside her.",
    "How absurd to swallow a bird!",
    "Imagine that, to swallow a cat!",
    "What a hog, to swallow a dog!",
    "Just opened her throat and swallowed a goat!",
    "I don't know how she swallowed a cow!"}

const lastSentence = "I don't know why she swallowed the fly. Perhaps she'll die."

const altLastSentence = "She's dead, of course!"

func Verse(v int) string {
	var out []string
    out = append(out,
                 fmt.Sprintf("I know an old lady who swallowed a %s.", animals[v-1]))
    if v < 8 {
        if v > 1 {
            out = append(out, secondSentence[v-1])
        }
        for i := 1; i < v; i++ {
            if animals[v-i-1] == "spider" {
                out = append(out,
                             fmt.Sprintf("She swallowed the %s to catch the %s that wriggled and jiggled and tickled inside her.",
                                         animals[v-i], animals[v-i-1]))
            } else {
            	out = append(out,
                             fmt.Sprintf("She swallowed the %s to catch the %s.",
                                         animals[v-i], animals[v-i-1]))
            }
        }
        out = append(out, lastSentence)
    } else {
        out = append(out, altLastSentence)
    }
    return strings.Join(out, "\n")
}

func Verses(start, end int) string {
	var out []string
    for i:= start; i <= end; i++ {
        out = append(out, Verse(i))
    }
    return strings.Join(out, "\n\n")
}

func Song() string {
	return Verses(1, 8)
}
