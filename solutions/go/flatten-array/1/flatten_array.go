package flatten

func Flatten(nested interface{}) []interface{} {
	res := []interface{}{}
    switch l := nested.(type) {
        case []interface{}:
        	for _, e := range l {
                if e != nil {
                    inner := Flatten(e)
                    if len(inner) > 0 {
                        res = append(res, inner...)
                    }
                }
            }
        default:
        	res = append(res, l)
    }
    return res
}