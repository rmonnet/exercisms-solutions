package linkedlist

import "errors"

// Since this list is associated with stack semantic (Push and Pop),
// we will store the elements in LIFO order.

type Node struct {
    value int
    next *Node
}

type List struct {
    head *Node
}

func New(elements []int) *List {
	res := &List{}
    for _, element := range elements {
        node := &Node{value: element, next: res.head}
        res.head = node
    }
    return res
}

func (l *List) Size() int {
	res := 0
    for n := l.head; n != nil; n = n.next {
        res++
    }
    return res
}

func (l *List) Push(element int) {
	node := &Node{value: element, next: l.head}
    l.head = node
}

func (l *List) Pop() (int, error) {
	if l.head == nil {
        return 0, errors.New("can't pop from an empty list")
    }
    res := l.head
    l.head = l.head.next
    return res.value, nil
}

func (l *List) Array() []int {
	size := l.Size()
    res := make([]int, size)
    idx := size - 1
    for n := l.head; n != nil; n = n.next {
        res[idx] = n.value
        idx--
    }
    return res
}

func (l *List) Reverse() *List {
	res := &List{}
    for n := l.head; n != nil; n = n.next {
        node := &Node{value: n.value, next: res.head}
        res.head = node
    }
    return res
}
