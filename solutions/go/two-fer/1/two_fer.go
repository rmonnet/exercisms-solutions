// package twofer provides a function to share pastries with somebody else.
package twofer

import "fmt"

// ShareWith generates a sentence you can use when sharing a pastry with somebody else.
// If you know there name, use it in the sentence, if not call them "you".
func ShareWith(name string) string {
	if name == "" {
        name = "you"
    }
    return fmt.Sprintf("One for %s, one for me.", name)
}
