package listops

// IntList is an abstraction of a list of integers which we can define methods on
type IntList []int

func (s IntList) Foldl(fn func(int, int) int, initial int) int {
    acc := initial
	for _, e := range s {
        acc = fn(acc, e)
    }
    return acc
}

func (s IntList) Foldr(fn func(int, int) int, initial int) int {
    acc := initial
	for i:= len(s)-1; i >= 0; i-- {
        acc = fn(s[i], acc)
    }
    return acc
}

func (s IntList) Filter(fn func(int) bool) IntList {
	res := make(IntList, 0, len(s))
    for _, e := range s {
        if fn(e) {
            res = append(res, e)
        }
    }
    return res
}

func (s IntList) Length() int {
	return len(s)
}

func (s IntList) Map(fn func(int) int) IntList {
	res := make(IntList, len(s))
    for i, e := range s {
        res[i] = fn(e)
    }
    return res
}

func (s IntList) Reverse() IntList {
	res := make(IntList, len(s))
    for i, e := range s {
        res[len(res)-1-i] = e
    }
    return res
}

func (s IntList) Append(lst IntList) IntList {
	return append(s, lst...)
}

func (s IntList) Concat(lists []IntList) IntList {
	res := s
    for _, list := range lists {
        res = res.Append(list)
    }
    return res
}
