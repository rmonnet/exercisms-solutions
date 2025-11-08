
export class HighScores {
  
  constructor(scores=[]) {
    this._scores = scores;
  }

  get scores() {
    return [...this._scores];
  }

  get latest() {
    if (this._scores.length > 0) return this._scores[this._scores.length-1];
  }

  get personalBest() {
    return this._scores.reduce((acc,val) => val > acc? val : acc, 0);
  }

  get personalTopThree() {
    // this.scores returns a copy, so the sort doesn't perturbe the recorded scores order.
    let descendingScores = this.scores.sort((a,b) => b - a);
    let lim = Math.min(3, descendingScores.length);
    return descendingScores.slice(0, 3);
  }
}
