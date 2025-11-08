

export class Song {

  static ANIMALS = ['fly', 'spider', 'bird', 'cat', 'dog', 'goat', 'cow', 'horse'];

  static EXCLAMATIVE = ['How absurd to swallow', 'Imagine that, to swallow', 'What a hog, to swallow',
    'Just opened her throat and swallowed', 'I don\'t know how she swallowed'];

  verse(stanza) {

    let lines = [];
    
    lines.push(`I know an old lady who swallowed a ${Song.ANIMALS[stanza-1]}.`);
    
    if (stanza == 8) {
      lines.push('She\'s dead, of course!');
    } else {
 
     if (stanza > 2) {
       lines.push(`${Song.EXCLAMATIVE[stanza-3]} a ${Song.ANIMALS[stanza-1]}!`);
      }

     for (let i = 0; i < stanza-3 ; i++) {
        lines.push(
            `She swallowed the ${Song.ANIMALS[stanza-1-i]} to catch the ${Song.ANIMALS[stanza-2-i]}.`);
      }
      
      if (stanza > 1) {
        let subject = (stanza == 2) ?
          'It' : `She swallowed the ${Song.ANIMALS[2]} to catch the ${Song.ANIMALS[1]} that`;
        lines.push(`${subject} wriggled and jiggled and tickled inside her.`);
        lines.push(`She swallowed the ${Song.ANIMALS[1]} to catch the ${Song.ANIMALS[0]}.`)
      }

      lines.push(`I don't know why she swallowed the ${Song.ANIMALS[0]}. Perhaps she'll die.`);
    }
    
    lines.push('');
    return lines.join('\n');
  }

  verses(from, to) {
    
    let lines = [];
    for (let i = from; i <= to; i++) {
      lines.push(this.verse(i));
    }
    lines.push('');
    console.log(lines.join('\n'));
    return lines.join('\n');
  }
}
