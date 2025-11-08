package react

import (
	"cmp"
	"slices"
)

// A Reactor manages linked cells.
type reactor struct {
	dependencies map[Cell][]Cell
	updateFns    map[Cell]func()
}

// UpdateDependents is called when the value of an InputCell is changed.
// It finds the outdated cells in the reactor and call their update functions
// in the order that minimize changes.
func (r *reactor) updateDependents(c Cell) {
	// To make sure we minimize the number of updates, we find all the cells
	// directly and indirectly depending from c and sort them per level of indirection.
	// We then call the update functions per increasing level of indirection.
	updateLevel := map[Cell]int{}
	toUpdate := r.dependencies[c]
	level := 1
	for len(toUpdate) > 0 {
		nextUpdate := []Cell{}
		for _, c := range toUpdate {
			if updateLevel[c] < level {
				updateLevel[c] = level
			}
			nextUpdate = append(nextUpdate, r.dependencies[c]...)
		}
		level++
		toUpdate = nextUpdate
	}
	cells := make([]Cell, 0, len(updateLevel))
	for cell := range updateLevel {
		cells = append(cells, cell)
	}
	slices.SortFunc(cells, func(a, b Cell) int {
		return cmp.Compare(updateLevel[a], updateLevel[b])
	})
	for _, cell := range cells {
		r.updateFns[cell]()
	}
}

// New creates a new reactor.
func New() Reactor {
	return &reactor{dependencies: map[Cell][]Cell{}, updateFns: map[Cell]func(){}}
}

// CreateInput creates an input cell linked into the reactor
// with the given initial value.
func (r *reactor) CreateInput(value int) InputCell {
	return &cell{value: value, reactor: r}
}

// CreateCompute1 creates a compute cell which computes its value
// based on one other cell. The compute function will only be called
// if the value of the passed cell changes.
func (r *reactor) CreateCompute1(c Cell, expr func(int) int) ComputeCell {
	res := &cell{value: expr(c.Value()), reactor: r}
	update := func() {
		newValue := expr(c.Value())
		if newValue != res.value {
			res.value = newValue
			res.processCallbacks()
		}
	}
	r.dependencies[c] = append(r.dependencies[c], res)
	r.updateFns[res] = update
	return res
}

// CreateCompute2 is like CreateCompute1, but depending on two cells.
// The compute function will only be called if the value of any of the
// passed cells changes.
func (r *reactor) CreateCompute2(c1 Cell, c2 Cell, expr func(int, int) int) ComputeCell {
	res := &cell{value: expr(c1.Value(), c2.Value()), reactor: r}
	update := func() {
		newValue := expr(c1.Value(), c2.Value())
		if newValue != res.value {
			res.value = newValue
			res.processCallbacks()
		}
	}
	r.dependencies[c1] = append(r.dependencies[c1], res)
	r.dependencies[c2] = append(r.dependencies[c2], res)
	r.updateFns[res] = update
	return res
}

// A Cell is conceptually a holder of a value.
// An InputCell has a changeable value, changing the value triggers updates to
// other cells.
type cell struct {
	value     int
	reactor   *reactor
	callbacks map[int]func(int)
	nextId    int
}

// ProcessCallbacks call all the registered callback functions for a ComputeCell
// when its value changes at the result of an update (not the initial setting).
func (c *cell) processCallbacks() {
	for _, callback := range c.callbacks {
		callback(c.value)
	}
}

// Value returns the current value of the cell.
func (c *cell) Value() int {
	return c.value
}

// SetValue sets the value of the cell.
func (c *cell) SetValue(value int) {
	if c.value == value {
		return
	}
	c.value = value
	c.reactor.updateDependents(c)
}

// AddCallback adds a callback which will be called when the value changes.
// It returns a Canceler which can be used to remove the callback.
func (c *cell) AddCallback(callback func(int)) Canceler {
	if c.callbacks == nil {
		c.callbacks = map[int]func(int){}
	}
	c.callbacks[c.nextId] = callback
	c.nextId++
	return &canceler{cell: c, id: c.nextId - 1}
}

// A Canceler is used to remove previously added callbacks, see ComputeCell.
type canceler struct {
	cell *cell
	id   int
}

// Cancel removes the callback.
func (c *canceler) Cancel() {
	if c.cell.callbacks == nil {
		return
	}
	delete(c.cell.callbacks, c.id)
}
