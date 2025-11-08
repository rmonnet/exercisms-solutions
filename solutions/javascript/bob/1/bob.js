
const isYelling = (msg) => (msg == msg.toUpperCase() && msg.match(/[A-Z]/));
const isAQuestion = (msg) => msg.trimEnd().endsWith('?');
const doesnotSayAnything = (msg) => msg.trim().length == 0;
  
export function hey(message) {
  
  if (doesnotSayAnything(message)) return 'Fine. Be that way!';
  if (isAQuestion(message) && isYelling(message)) return "Calm down, I know what I'm doing!";
  if (isYelling(message)) return 'Whoa, chill out!';
  if (isAQuestion(message)) return  'Sure.';
  return 'Whatever.';
};
