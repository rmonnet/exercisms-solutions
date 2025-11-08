import re

def translate_word(text):

    # Rule 1, word starts with a vowel.
    if re.match(r'([aeiou]|xr|yt)', text):
        return text + 'ay'

    # We have eliminated words starting with vowel,
    # The word has to start with a consonant.
    # Use this to assume the first letter is a consonant.

    # Rule 3, (single) consonant followed by 'qu'.
    if text[1:].startswith('qu'):
        return text[3:] + text[0:3] + 'ay'

    # Rule 4 derives directly from rule 2 if we correctly
    # identify the consonant clusters.
    # Rule 2, words starts with consonant (including consonant cluster).
        
    # Check for consonent cluster (considering 'qu' as a cluster).
    cluster_size = re.match(r'(qu|([^aeiou][^aeiouy]*))', text).end()
    return text[cluster_size:] + text[0:cluster_size] + 'ay'

    # we should have handled all the cases above
    raise ValueError(f'no rule for {text}')

def translate(text):
    new_words = [translate_word(w) for w in text.split(' ')]
    return ' '.join(new_words)