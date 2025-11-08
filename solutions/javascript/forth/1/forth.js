
// The Forth class defines a simple forth interpreter.
export class Forth {

  static BUILTINS = ['+', '-', '*', '/', 'dup','drop', 'swap', 'over'];
 
  static isDigit = (word) => /^-?\d+$/.test(word);

  // Initializes a new Forth machine.
  constructor() {
    // The stack hold operands for pending operations as well as the result of previous operations.
    this._stack = [];
    // The dictionary holds the user defined words.
    this._dict = {};
    // The current definition hold the definition in progress when forth is in compile mode (i.e. between ':'
    // and ';').
    // For simplicity, the name of the new word is temporarely stored as the first word of the definition.
    this._currentDef = null;
  }

  // Evaluates a line of user input.
  evaluate(input) {
    for (const word of input.split(' ')) {
     this.execute(word.toLowerCase());
    }
  }

  // Executes the definition of a user-defined word.
  // The definition is presented as an array of words (primitives or user-defined).
  executeIndirect(definition) {
      for (const word of definition) {
          this.execute(word);
      }
  }

  // Executes a single word.
  // If Forth is in compile-mode, the word is added to the current definition except if it is ';' or ':'.
  //   - ';' terminates compile-mode and the definition is stored in the dictionary
  //   = ':' would signal a nested definition and is not supported at this time
  // If Forth is in run-mode, the word is executed directly if a built-in, added to the stack if an
  //   in integer or its definition is executed indirectly if the word is a user-defined word.
  // If a user-defined word definition contains user-defined word, they are represented as embedded definitions
  //   (aka embedded arrays of forth words).
  execute(word) {
    
    if (this._currentDef) this.compile(word);
    else if (Forth.isDigit(word)) this.push(Number.parseInt(word));
    // user definition overwrite builtins and is therefore checked first
    else if (word in this._dict) this.executeIndirect(this._dict[word]);
    else if (word == '+') this.add();
    else if (word == '-') this.subtract();
    else if (word == '*') this.multiply();
    else if (word == '/') this.divide();
    else if (word ==  'dup') this.dup();
    else if (word == 'drop') this.pop();
    else if (word ==  'swap') this.swap();
    else if (word ==  'over') this.over();
    else if (word == ':') this._currentDef = [];
    else if (word == ';') throw new Error('; found outside a definition');
    else throw new Error('Unknown command');
  }

  // Compiles a Forth word into the current definition.
  //  The name of the word is temporarely stored at the head of the definition.
  compile(word) {

    // nested definition, not allowed
    if (word == ':') throw new Error('Nested definition not allowed');
    
    // end of definition
    if (word == ';') {
      if (this._currentDef.length == 0) throw new Error('Empty definition');
      this._dict[this._currentDef.shift()] = this._currentDef;
      this._currentDef = null;
      
    // beginning of definition, the word is the name of the user-defined word
    } else if (this._currentDef.length == 0) {
      if (Forth.isDigit(word)) throw new Error('Invalid definition');
      this._currentDef.push(word);
      
    // a word part of the definition
    } else {
      if (word in this._dict) this._currentDef.push(this._dict[word])
      else if (Forth.isDigit(word)) this._currentDef.push(word);
      else if (Forth.BUILTINS.includes(word)) this._currentDef.push(word);
      else throw new Error('Unknown command');
    }
  }

  get stack() {
    return this._stack;
  }

  pop() {
    if (this._stack.length == 0) throw new Error('Stack empty');
    return this._stack.pop();
  }

  push(value) {
    this._stack.push(value);
  }

  // return the ith value on the stack without modifying the stack
  // (index = 0 is the top of the stack, index = 1 is the second element on the stack, ...)
  peek(index) {
    if (this._stack.length < index+1) throw new Error('Stack empty');
    return this._stack[this._stack.length-index-1];
  }

  add() {
    this.push(this.pop() + this.pop());  
  }

  subtract() {
    const rightOp = this.pop();
    this.push(this.pop() - rightOp);
  }
  
  multiply() {
    this.push(this.pop() * this.pop());
  }
  
  divide() {
    const rightOp = this.pop();
    if (rightOp == 0) throw new Error('Division by zero')
    this.push(Math.trunc(this.pop() / rightOp));
  }

  dup() {
    this.push(this.peek(0));
  }

  swap() {
    const first = this.pop();
    const second = this.pop();
    this.push(first);
    this.push(second);
  }

  over() {
    this.push(this.peek(1));
  }

}
