// Answers simple arithmetics problems
export function answer(question) {

  // syntax:
  // - all questions are in the form 'What is<expression>?'
  // - <expression> is a series of number and operations (number (operation number)+)
  //   separated by spaces
  // - the only available operations are 'plus', 'minus', 'multiplied by', and 'divided by'
  // - there is no operator precedence, all operations are strictly left to right

  // check the general form of the question
  const parsedQuestion = question.match(/What is(.*)\?/);
  if (!parsedQuestion) throw new Error('Unknown operation');

  // simplify the question to facilitate parsing
  const simplerQuestion = parsedQuestion[1]
    .replace(/multiplied by/g, 'multipliedby')
    .replace(/divided by/g, 'dividedby');

  // parse the expression in a series of tokens
  const operations = simplerQuestion.trim().split(' ')

  // <expression> must start with a number
  let result = Number.parseInt(operations[0]);
  if (Number.isNaN(result)) throw new Error('Syntax error');
  
  for (let i = 1; i < operations.length; i += 2) {
    
    // we now expect a block of 2 elements (operation number)
    
    // check the operation
    if (!operations[i].match(/(plus|minus|multipliedby|dividedby)/)) {
      if (operations[i].match(/\d+/)) throw new Error('Syntax error');
        throw new Error('Unknown operation');
    }
    // check the number
    if (i == operations.length-1) throw new Error('Syntax error');
    let operand = Number.parseInt(operations[i+1]);
    if (Number.isNaN(operand)) throw new Error('Syntax error');

    // perform the operation
    switch (operations[i]) {
      case 'plus':
        result += operand;
        break;
      case 'minus':
        result -= operand;
        break;
      case 'multipliedby':
        result *= operand;
        break;
      case 'dividedby':
        result /= operand;
        break;
    }
  }
  return result;
};

