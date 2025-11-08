package flatten

// Note: 'any' and 'interface{}' are type aliases.
// The former just keeps the code cleaner.
func Flatten(nested any) []any {
	res := []any{}
    switch l := nested.(type) {
        case []any:
        	for _, e := range l {
                res = append(res, Flatten(e)...)
            }
        case any:
        	res = append(res, l)
        // Note: nil doesn't implement the any interface
        // so it would fall under the (non-existant) default
        // case here.
    }
    return res
}