package pov

type Tree struct {
	value    string
	children []*Tree
}

// New creates and returns a new Tree with the given root value and children.
func New(value string, children ...*Tree) *Tree {
	return &Tree{value: value, children: children}
}

// Value returns the value at the root of a tree.
func (tr *Tree) Value() string {
	return tr.value
}

// Children returns a slice containing the children of a tree.
// There is no need to sort the elements in the result slice,
// they can be in any order.
func (tr *Tree) Children() []*Tree {
	return tr.children
}

// String describes a tree in a compact S-expression format.
// This helps to make test outputs more readable.
// Feel free to adapt this method as you see fit.
func (tr *Tree) String() string {
	if tr == nil {
		return "nil"
	}
	result := tr.Value()
	if len(tr.Children()) == 0 {
		return result
	}
	for _, ch := range tr.Children() {
		result += " " + ch.String()
	}
	return "(" + result + ")"
}

// POV problem-specific functions

// FromPov returns the pov from the node specified in the argument.
func (tr *Tree) FromPov(from string) *Tree {
	if tr.value == from {
		return tr
	}
	node, path := tr.findNode(from, []*Tree{})
	if node == nil {
		return nil
	}
	newRoot := New(node.value, node.children...)
	newParent := newRoot
	toRemove := from
	for i := len(path) - 1; i >= 0; i-- {
		curNode := path[i]
		// We know the node to remove is a child of the curNode because findNode() built
		// the path this way. No need to check for index == -1.
		childIndex := curNode.childIndex(toRemove)
		newNode := New(curNode.value, curNode.children[:childIndex]...)
		newNode.children = append(newNode.children, curNode.children[childIndex+1:]...)
		newParent.children = append(newParent.children, newNode)
		newParent = newNode
		toRemove = curNode.value
	}
	return newRoot
}

// PathTo returns the shortest path between two nodes in the tree.
func (tr *Tree) PathTo(from, to string) []string {
	if from == to {
		return []string{from}
	}
	treeFrom := tr.FromPov(from)
	if treeFrom == nil {
		return []string{}
	}
	node, path := treeFrom.findNode(to, []*Tree{})
	if node == nil {
		return []string{}
	}
	res := make([]string, 0, len(path))
	for _, node := range path {
		res = append(res, node.value)
	}
	res = append(res, to)
	return res
}

func (tr *Tree) childIndex(value string) int {
	for i, child := range tr.children {
		if child.value == value {
			return i
		}
	}
	return -1
}

func (tr *Tree) findNode(from string, curPath []*Tree) (node *Tree, fullPath []*Tree) {
	if tr.value == from {
		return tr, curPath
	}
	for _, child := range tr.children {
		fullPath := append(curPath, tr)
		if child.value == from {
			return child, fullPath
		}
		node, fullPath := child.findNode(from, fullPath)
		if node != nil {
			return node, fullPath
		}
	}
	return nil, nil
}
