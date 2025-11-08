
// The song next verse is built by inserting a new sentence after the second space of the previous verse.

export class House {

  static SENTENCES = [
    'the malt\nthat lay in ',
    'the rat\nthat ate ',
    'the cat\nthat killed ',
    'the dog\nthat worried ',
    'the cow with the crumpled horn\nthat tossed ',
    'the maiden all forlorn\nthat milked ',
    'the man all tattered and torn\nthat kissed ',
    'the priest all shaven and shorn\nthat married ',
    'the rooster that crowed in the morn\nthat woke ',
    'the farmer sowing his corn\nthat kept ',
    'the horse and the hound and the horn\nthat belonged to ',
    ];

  // Produces the level-th verse.
  static verse(level, iter=1, sentence='This is the house that Jack built.') {

    if (iter == level) return sentence.split('\n');

    const secondSpace = sentence.indexOf(' ', sentence.indexOf(' ')+1);
    const front = sentence.substring(0, secondSpace+1);
    const back = sentence.substring(secondSpace+1, sentence.length);
    return House.verse(level, iter+1, `${front}${House.SENTENCES[iter-1]}${back}`);
  }

  // Produces all the verses between startVerse and endVerse (inclusive).
  static verses(startVerse, endVerse) {
    
    let song = [];
    for (let level = startVerse; level <= endVerse; level++) {
      if (level != startVerse) song.push('');
      song = song.concat(House.verse(level))
    }
    return song;
  }

}
