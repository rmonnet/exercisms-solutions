// Package proverb provides operations to generate proverbs.
package proverb

import "fmt"

// Proverb generates a proverb from a list of names.
func Proverb(rhyme []string) []string {
    proverbs := make([]string, len(rhyme))
    for i:= 0; i < len(rhyme); i++ {
    	if i < len(rhyme) -1 {
            proverbs[i] = fmt.Sprintf("For want of a %s the %s was lost.", rhyme[i], rhyme[i+1])
    	} else {
        	proverbs[i] = fmt.Sprintf("And all for the want of a %s.", rhyme[0])
    	}
    }
	return proverbs
}
