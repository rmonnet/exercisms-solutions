import gleam/string
import gleam/dict.{type Dict}
import gleam/list
import gleam/int
import gleam/option.{None, Some}

const title = "Team                           | MP |  W |  D |  L |  P"

type Score {
  Score(wins: Int, draws: Int, losses: Int)
}

pub fn tally(input: String) -> String {
  case input {
    "" -> title
    _ -> input
      |> string.split("\n")
      |> list.fold(dict.new(), score_game)
      |> print_scores
  }
}

fn score_game(scores: Dict(String, Score), line: String) -> Dict(String, Score) {
  let assert [team1, team2, result] = string.split(line, ";")
  scores
  |> dict.upsert(team1, fn(results) {
    case results {
      None -> update_score(Score(0, 0, 0), result)
      Some(score) -> update_score(score, result)
    }
  })
  |> dict.upsert(team2, fn(results) {
    case results {
      None -> update_score(Score(0, 0, 0), revert_result(result))
      Some(score) -> update_score(score, revert_result(result))
    }
  })
}

fn revert_result(result: String) -> String {
  case result {
    "win" -> "loss"
    "loss" -> "win"
    _ -> result
  }
}

fn update_score(score: Score, result: String) -> Score {
  case result {
    "win" -> Score(..score, wins: score.wins+1)
    "draw" -> Score(..score, draws: score.draws+1)
    "loss" -> Score(..score, losses: score.losses+1)
    _ -> panic as "Unrecognized result"
  }
}

fn print_scores(scores: Dict(String, Score)) -> String {
  dict.keys(scores) |> list.sort(fn(a, b) {
    let assert Ok(score_a) = dict.get(scores, a)
    let assert Ok(score_b) = dict.get(scores, b)
    int.compare(points(score_b), points(score_a))
  })
  |> list.fold([title], fn(acc, team) {
    let assert Ok(score) = dict.get(scores, team)
    [print_team_score(team, score), ..acc]
  })
  |> list.reverse
  |> string.join("\n")
}

fn print_team_score(team: String, score: Score) -> String {
  [string.pad_right(team, 30, " "),
  pad_int(matches_played(score)),
  pad_int(score.wins),
  pad_int(score.draws),
  pad_int(score.losses),
  pad_int(points(score))]
  |> string.join(" |")
}

fn pad_int(value: Int) -> String {
  int.to_string(value)
  |> string.pad_left(3, " ")
}

fn points(score: Score) -> Int {
  3 * score.wins + score.draws
}

fn matches_played(score: Score) -> Int {
  score.wins + score.draws + score.losses
}