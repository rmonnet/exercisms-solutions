package strain

type Predicate[T any] func(x T) bool

func Keep[T any](list []T, pred Predicate[T]) []T {
    var res []T
    for _, elem := range list {
        if pred(elem) {
            res = append(res, elem)
        }
    }
    return res
}

func Discard[T any](list []T, pred Predicate[T]) []T {
    var res []T
    for _, elem := range list {
        if !pred(elem) {
            res = append(res, elem)
        }
    }
    return res
}
