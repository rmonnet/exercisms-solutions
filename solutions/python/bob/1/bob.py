import re

question = re.compile(r'.*\?\s*$')
blank = re.compile(r'\s*$')

def response(hey_bob):
    if hey_bob.isupper() and question.match(hey_bob):
        return "Calm down, I know what I'm doing!"
    if question.match(hey_bob):
        return 'Sure.'
    if hey_bob.isupper():
        return 'Whoa, chill out!'
    if blank.match(hey_bob):
        return 'Fine. Be that way!'
    return "Whatever."
