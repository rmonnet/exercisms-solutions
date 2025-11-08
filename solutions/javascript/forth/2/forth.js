

// The Forth class defines a simple forth interpreter.
export class Forth {

  // Forth words that are always executed regardless of the run/compile mode.
  static IMMEDIATE = [':', ';'];

  // Built-in Forth functions.
  static BUILTINS = {
    '+': function() {
        const [opL, opR] = this._pop(2);
        this._push(opL + opR);
      },
    '-': function() {
        const [opL, opR] = this._pop(2);
        this._push(opL - opR);
      },
    '*': function() {
        const [opL, opR] = this._pop(2);
        this._push(opL * opR);
      },
    '/': function() {
        const [opL, opR] = this._pop(2);
        if (opR == 0) throw new Error('Division by zero')
        this._push(Math.trunc(opL / opR));
      },
    'dup': function() {
        const top = this._pop(1)[0];
        this._push(top, top);
      },
    'swap': function() {
        const [second, first] = this._pop(2);
        this._push(first, second);
      },
    'over': function() {
        const [second, first] = this._pop(2);
        this._push(second, first, second);
      },
    'drop': function() {
        this._pop();
      },
    ':': function() {
        if (this._currentDef) throw new Error('Nested definition not allowed');
        // Enter compilation mode.
        this._currentDef = [];
        this._currentWord = '';
      },
    ';': function() {
        if (!this._currentDef) throw new Error('; found outside a definition');
        if (this._currentDef.length == 0) throw new Error('Empty definition');
        this._dict[this._currentWord] = this.compileDefinition(this._currentDef);
        // Enter run mode.
        this._currentDef = null;
    }
  }
 
  static isDigit = (word) => /^-?\d+$/.test(word);

  // Initializes a new Forth machine.
  constructor() {
    // The stack hold operands for pending operations as well as the result of previous operations.
    this._stack = [];
    // The dictionary holds the user defined words.
    this._dict = {...Forth.BUILTINS};
    // The current definition hold the definition in progress when forth is in compile mode (i.e. between ':'
    // and ';').
    this._currentDef = null;
  }

  // Evaluates a line of user input.
  evaluate(input) {
    for (const word of input.split(' ')) {
     this.execute(word.toLowerCase());
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
    
    if (this._currentDef && !Forth.IMMEDIATE.includes(word)) {
      this.compile(word);
      return;
    }
      
    if (Forth.isDigit(word)) this._push(Number.parseInt(word));
    else if (word in this._dict) this._dict[word].call(this);
    else throw new Error('Unknown command');
  }

  // Compiles a user defined word into a javascript function that can be added to the dictionary.
  compileDefinition(definition) {
      return function() {
          definition.forEach(fun => fun.call(this));
      }
  }

  // Compiles a number into a javascript function that pushes the number on the stack.
  compileNumber(n) {
    let number = Number.parseInt(n);
    return function() {
      this._push(number);
    }
  }

  // Compiles a Forth word into the current definition.
  compile(word) {

    // beginning of definition, the word is the name of the user-defined word
    if (!this._currentWord) {
      if (Forth.isDigit(word)) throw new Error('Invalid definition');
      this._currentWord = word;
      
    // a word part of the definition
    } else {
      if (Forth.isDigit(word)) this._currentDef.push(this.compileNumber(word));
      else if (word in this._dict) this._currentDef.push(this._dict[word])
      else throw new Error('Unknown command');
    }
  }

  // Returns the state of the current Forth operand stack.
  get stack() {
    return this._stack;
  }

  // Get the n top values from the stack.
  // Returns an array with the top of the stack to the right,
  // i.e. if stack is [1, 2, 3], then _pop(2) returns [2, 3].
  _pop(n=1) {
    if (this._stack.length < n) throw new Error('Stack empty');
    return this._stack.splice(-n, n);
  }

  // Adds the values to the top of the stack.
  _push(...values) {
    values.forEach(value => this._stack.push(value));
  }
}
