import gleam/result

pub type Player {
  Black
  White
}

pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}

pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  case rule1(game) {
    Error(msg) -> Game(..game, error: msg)
    Ok(game1) -> case game1 |> rule2() |> rule3() {
      Error(msg) -> Game(..game, error: msg)
      Ok(game3) -> case rule4(game3) {
        Error(msg) -> Game(..game, error: msg)
        Ok(game4) -> Game(..game4, player: switch_player(game.player))
      }
    }
  }
}

fn switch_player(player: Player) -> Player {
  case player {
    White -> Black
    Black -> White
  }
}