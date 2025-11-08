class HighScores {
  List<int> _scores = [];
  List<int> _sorted_scores = [];

  HighScores(List<int> scores) {
    this._scores = List.of(scores);
    this._sorted_scores = List.of(scores);
    this._sorted_scores.sort((a, b) => b - a);
  }

  List<int> get scores {
    return List.of(this._scores);
  }

  int latest() {
    return this._scores.last;
  }

  int personalBest() {
    return this._sorted_scores.first;
  }

  List<int> personalTopThree() {
    return List.of(this._sorted_scores.take(3));
  }
}
