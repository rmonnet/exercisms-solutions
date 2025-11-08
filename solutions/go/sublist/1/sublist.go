package sublist

// Relation type is defined in relations.go file.

// StartWith checks if l1 starts with l2. It assumes len(l2) <= len(l1)
func startWith(l1, l2 []int) bool {
    for i, e2 := range l2 {
        if l1[i] != e2 {
        	return false
        }
    }
    return true
}

func Sublist(l1, l2 []int) Relation {
    cmp := RelationUnequal
    switch {
        case len(l1) == 0 && len(l2) == 0:
        	cmp = RelationEqual
    	case len(l1) == 0:
        	cmp = RelationSublist
    	case len(l2) == 0:
        	cmp = RelationSuperlist
		case len(l1) == len(l2):
        	if startWith(l1, l2) {
            	cmp = RelationEqual
        	}
    	case len(l1) < len(l2):
        	for offset := 0; offset < len(l2)-len(l1)+1; offset ++ {
            	if startWith(l2[offset:], l1) {
                	cmp = RelationSublist
            	}
        	}
    	case len(l2) < len(l1):
        	for offset := 0; offset < len(l1)-len(l2)+1; offset ++ {
                if startWith(l1[offset:], l2) {
            		cmp = RelationSuperlist
        		}
    		}
    }
    return cmp
}
