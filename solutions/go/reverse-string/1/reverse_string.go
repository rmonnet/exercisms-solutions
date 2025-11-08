package reverse

func Reverse(input string) string {
	normal := []rune(input)
    length := len(normal)
    reverse := make([]rune, length)
    for i := 0; i < length; i++ {
        reverse[i] = normal[length-1-i]
    }
    return string(reverse)
}
