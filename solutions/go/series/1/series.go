package series

func All(n int, s string) []string {
	res := []string{}
    for i:= 0; i+n <= len(s); i++ {
        res = append(res, s[i:i+n])
    }
    return res
}

func UnsafeFirst(n int, s string) string {
	return s[0:n]
}
