package linkedlist

import (
    "errors"
)

// Define List and Node types here.
type Node struct {
    prev *Node
    next *Node
	// Note: The tests expect Node type to include an
    // exported field with name Value to pass.
    Value any
}

type List struct {
    head *Node
    tail *Node
}


func NewList(elements ...any) *List {
    res := &List{}
	for i, element := range elements {
        node := &Node{Value: element}
        node.prev = res.tail
        if i == 0 {
            res.head = node
        } else {
            res.tail.next = node
        }
        res.tail = node
    }
    return res
}

func (n *Node) Next() *Node {
	return n.next
}

func (n *Node) Prev() *Node {
	return n.prev
}

func (l *List) Unshift(v any) {
	node := &Node{Value: v}
    node.next = l.head
    if l.head != nil {
        l.head.prev = node
    }
    l.head = node
    if l.tail == nil {
        l.tail = node
    }
}

func (l *List) Push(v any) {
	node := &Node{Value: v}
    node.prev = l.tail
    if l.tail != nil {
        l.tail.next = node
    }
    l.tail = node
    if l.head == nil {
        l.head = node
    }
}

func (l *List) Shift() (any, error) {
    if l.head == nil {
        return 0, errors.New("Cannot Shift empty list")
    }
    res := l.head.Value
    if l.head == l.tail {
        l.head = nil
        l.tail = nil
    } else {
        l.head.next.prev = nil
        l.head = l.head.next
    }
    return res, nil
}

func (l *List) Pop() (any, error) {
    if l.head == nil {
        return 0, errors.New("Cannot Pop empty list")
    }
    res := l.tail.Value
    if l.head == l.tail {
        l.head = nil
        l.tail = nil
    } else {
        l.tail.prev.next = nil
        l.tail = l.tail.prev
    }
    return res, nil
}

func (l *List) Reverse() {
    nextNode := l.tail;
	for nextNode != nil {
        n := nextNode
        // Increment the node before we modify it so we don't mess
        // up the loop.
        nextNode = nextNode.prev
        n.prev, n.next = n.next, n.prev
    }
    l.head, l.tail = l.tail, l.head
}

func (l *List) First() *Node {
	return l.head
}

func (l *List) Last() *Node {
	return l.tail
}
