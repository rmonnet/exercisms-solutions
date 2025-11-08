// We could use a Javascript array to store the element of the list but since the exercise is more about
// understanding how the implementation of a list would work.
// We will build the list as a linked list.
//
// The linked list is built out of cells with each cell containing the value of an element and pointing
// to the next cell in the list.
// List: Head -> [Value] -> [Value] -> ... -> null.
//
// We will implement a single linked list (only use forwards links) vs. a double linked list (use forwards
// and backwards links), this makes a couple of operations inefficients (append, length, foldr) but makes
// the rest simpler; it is also closer to historical implementations for list oriented languages such as lisp.
//
// A Cell is represented as a Javascript object with a 'value' and a 'next' field.


// The List class defines flexible containers to manipulate list of objects.
export class List {

  // Constructs a list and populate with the provided values (from a javascript array).
  constructor(values) {

    this._head = null;
    if (values == null) return;

    // we need to keep track of the previous element so we can chain the cell (with the 'next' field).
    let previous = null;
    for (const value of values) {
      const cell = {value: value};
      if (this._head == null) this._head = cell;
      if (previous) previous.next = cell;
      previous = cell;
    }
  }

  // Returns the values of the list as a javascript array (for testing).
  get values() {

    if (this._head == null) return [];

    // We can iterate through the list using the 'next' pointers.
    // The for loop iteration is to go the the 'next' pointer.
    // The for loop termination test is when the 'next' pointer is null (undefined really).
    const result = [];
    for (let i = this._head; i != null; i = i.next) result.push(i.value);
    return result;
  }

  // Add all elements of the list to the end of this list.
  append(list) {

    if (list == null) return this;
    
    // First find the tail of this list.
    let tail = this._head;
    while (tail && tail.next) tail = tail.next;

    // Then add copies of all the elements from 'list'.
    let previous = tail;
    for (let i = list._head; i != null; i = i.next) {
      const cell = {value: i.value};
      if (!this._head) this._head = cell;
      if (previous) previous.next = cell;
      previous = cell;
    }
    return this;
  }

  // Concatenates a list of lists into a single flat list.
  // Assume a single nesting level (will not flatten deeper nested levels).
  concat(listOfList) {

    if (listOfList == null) return this;
    
    for (let i = listOfList._head; i != null; i = i.next) {
      // if we wanted to support any level of nesting, we would check
      // if 'i.value' is a list or a single element.
      // If it is a single element we could just add it to the end of the list
      // without calling append.
      this.append(i.value);
    }
    return this;
  }

  // Given predicate, return a list of only this list elements that satisfy the predicate.
  filter(predicate) {

    const filteredList = new List();
    let previous = null;
    
    for (let i = this._head; i != null; i = i.next) {
      if (predicate(i.value)) {
        const cell = {value: i.value};
        if (!filteredList._head) filteredList._head = cell;
        if (previous) previous.next = cell;
        previous = cell;
      }
    }
    return filteredList;
    
  }

  // Returns a list of the result of calling 'fun' on each element of this list. 
  map(fun) {
    
    const mappedList = new List();
    let previous = null;
    
    for (let i = this._head; i != null; i = i.next) {
      const cell = {value: fun(i.value)};
      if (!mappedList._head) mappedList._head = cell;
      if (previous) previous.next = cell;
      previous = cell;
    }
    return mappedList;
  }

  // Returns the list of the list.
  length() {

    if (this._head == null) return 0;

    let len = 0;
    for (let i = this._head; i != null; i = i.next) len++;
    return len;
  }

  // Returns the result of reducing this list by calling each element consecutively
  // with 'fun(acc,element)' and using the result as the next value of 'acc'.
  // The elements are processed first to last.
  foldl(fun, acc) {

    for (let i = this._head; i != null; i = i.next) acc = fun(acc, i.value);
    return acc;
  }

  // Returns the result of reducing this list by calling each element consecutively
  // with 'fun(acc,element)' and using the result as the next value of 'acc'.
  // The elements are processed last to first.
  foldr(fun, acc) {
    
    // We could use the same base algorithm we use in reverse (build backwards pointers)
    // but this is simpler.
    return this.reverse().foldl(fun, acc);
    
  }

  // Return a reversed copy of the list.
  reverse() {
    
    // We need to build a list of backward pointers from the tail of the list so we can
    // iterate backward through the list.
    // Since this is javascript, we can just store the pointers in the cell object themselves.

    if (this._head == null) return new List();

    // Compute the backward pointers
    let previous = null;
    let tail = null;
    for (let i = this._head; i != null; i = i.next) {
      i.previous = previous;
      previous = i;
      tail = i;
    }

    // now build a list by going backward from the tail
    const reversedList = new List();
    previous = null;
    
    for (let i = tail; i != null; i = i.previous) {
      let cell = {value: i.value};
      if (reversedList._head == null) reversedList._head = cell;
      if (previous) previous.next = cell;
      previous = cell;
    }

    return reversedList;
  }
}
