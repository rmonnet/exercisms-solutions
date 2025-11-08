package house

import "strings"

var content = []string{
	" the house that Jack built",
    " the malt\nthat lay in",
    " the rat\nthat ate",
    " the cat\nthat killed",
    " the dog\nthat worried",
    " the cow with the crumpled horn\nthat tossed",
    " the maiden all forlorn\nthat milked",
    " the man all tattered and torn\nthat kissed",
    " the priest all shaven and shorn\nthat married",
    " the rooster that crowed in the morn\nthat woke",
    " the farmer sowing his corn\nthat kept",
    " the horse and the hound and the horn\nthat belonged to"}

func Verse(v int) string {
	var out strings.Builder
    out.WriteString("This is")
    for i := v-1; i >= 0; i-- {
        out.WriteString(content[i])
    }
    out.WriteString(".")
    return out.String()
}

func Song() string {
	var out []string
    for i := 0; i < len(content); i++ {
        out = append(out, Verse(i+1))
    }
    return strings.Join(out, "\n\n")
}
