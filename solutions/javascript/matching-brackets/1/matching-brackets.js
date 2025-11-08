
export function isPaired(expression) {
  
  // As we go through the expression, keep track of the opening brackets/parentheses (using a stack).
  // When we find a closing bracket/parenthesis, make sure it matches the last open one and discard the pair.
  // At the end of the sentence, there should be no open backet/parenthesis left.

  let tokens = [];
  for (const c of expression) {
    if (c == '[' || c == '(' || c == '{') {
      tokens.push(c)
    } else if (c == ']') {
      if (tokens.pop() != '[') return false;
    } else if (c == ')') {
      if (tokens.pop() != '(') return false;
    } else if (c == '}') {
      if (tokens.pop() != '{') return false;
    }
  }
  return tokens.length == 0;
};
