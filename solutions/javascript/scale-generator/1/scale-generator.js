
export class Scale {

  static SIZE = 12;
  static SHARP = ['A', 'A#', 'B', 'C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#'];
  static FLAT = ['A', 'Bb', 'B', 'C', 'Db', 'D', 'Eb', 'E', 'F', 'Gb', 'G', 'Ab'];
  static USE_FLATS = new Set(['F', 'Bb', 'Eb', 'Ab', 'Db', 'Gb', 'd', 'g', 'c', 'f', 'bb', 'eb']);
  static INTERVALS = {'m': 1, 'M': 2, 'A': 3};

  constructor(tonic) {

    // Figure which chromatic scale to use (with sharps or flats)
    // and correct the tonic to the associated major (use uppercase followed by b/#).
    this.scale = Scale.USE_FLATS.has(tonic) ? Scale.FLAT : Scale.SHARP;
    tonic = tonic.replace(/^[a-g]/, c => c.toUpperCase());
    this.tonicIndex = this.scale.indexOf(tonic);
  }

  chromatic() {

    // Returns the next 12 notes in the scale, starting with the tonic.
    // The scale is periodic.
    let result = [];
    for (let i = 0; i < Scale.SIZE; i++) {
      result.push(this.scale[(this.tonicIndex+i) % Scale.SIZE])
    }
    return result;
  }

  interval(intervals) {

    // Use the intervals (m, M, and A) from intervals to compute the next note in the scale.
    // Starts with the tonic.
    let result = [];
    let nextIndex = this.tonicIndex;
    for (const i of intervals) {
      result.push(this.scale[nextIndex % Scale.SIZE])
      nextIndex += Scale.INTERVALS[i];
    }
    return result;
  }
}
