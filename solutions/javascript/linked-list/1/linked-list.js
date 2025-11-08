// The class Node defines the nodes elements of the double linked list.
class Node {

  // Constructs a Node with the given value.
  // The Node must be connected to his predecessor and successor when inserted into the
  // list.
  constructor(value) {
    this.value = value;
    this.next = null;
    this.previous = null;
  }
}

// The class LinkedList defines a doubly linked list.
// The members head and tail point to the Nodes at the beggining and end of the list.
// Each time the list is modified (Node inserted or removed) the connection between
// adjacent nodes and head/tail must be updated.
export class LinkedList {

  // Constructs an empty list.
  constructor() {
    this.head = null;
    this.tail = null;
  }

  // Insert a Node with value at the end of the list.
  push(value) {
    const node = new Node(value);
    node.previous = this.tail;
    if (this.tail !== null) this.tail.next = node;
    this.tail = node;
    if (this.head === null) this.head = node;
  }

  // Remove the Node at the end of the list and return its value.
  pop() {
    const node = this.tail;
    if (node !== null) {
      this.tail = node.previous;
      if (this.head === node) this.head = null;
      return node.value;
    }
  }

  // Remove the Node at the beggining of the list and return its value.
  shift() {
    const node = this.head;
    if (node != null) {
      this.head = node.next;
      if (this.tail === node) this.tail = null;
      return node.value;
    }
  }

  // Insert a Node with value at the beginning of the list.
  unshift(value) {
    const node = new Node(value);
    node.next = this.head;
    if (this.head !== null) this.head.previous = node;
    this.head = node;
    if (this.tail === null) this.tail = node;
  }

  // Delete the first node with the given value.
  delete(value) {
    for (let node = this.head; node !== null; node = node.next) {
      if (node.value === value) {
        if (node.previous !== null) node.previous.next = node.next;
        if (node.next !== null) node.next.previous = node.previous;
        if (this.tail === node) this.tail = node.previous;
        if (this.head === node) this.head = node.next;
        break;
      }
    }
  }

  // Return the number of elements in the list.
  count() {
    let result = 0;
    for (let node = this.head; node !== null; node = node.next) result++;
    return result;
  }
}
