import gleam/list

pub opaque type Frame {
  Frame(rolls: List(Int), bonus: List(Int))
}

pub type Game {
  Game(frames: List(Frame))
}

pub type Error {
  InvalidPinCount
  GameComplete
  GameNotComplete
}

pub fn roll(game: Game, pins: Int) -> Result(Game, Error) {
  case pins > 10 || pins < 0 {
    True -> Error(InvalidPinCount)
    False ->
      case game.frames, list.length(game.frames) {
        [], _ -> Ok(Game([Frame(rolls: [pins], bonus: [])]))
        [Frame(rolls: [10], bonus: []), Frame(rolls: [10], bonus: [10]), ..rest],
          10
        ->
          Ok(
            Game([
              Frame(rolls: [10], bonus: [pins]),
              Frame(rolls: [10], bonus: [10, pins]),
              ..rest
            ]),
          )
        [Frame(rolls: [10], bonus: []), ..rest], 10 ->
          Ok(Game([Frame(rolls: [10], bonus: [pins]), ..rest]))
        [Frame(rolls: [10], bonus: [10]), ..rest], 10 ->
          Ok(Game([Frame(rolls: [10], bonus: [10, pins]), ..rest]))
        [Frame(rolls: [10], bonus: [b1]), ..], 10 if b1 + pins > 10 ->
          Error(InvalidPinCount)
        [Frame(rolls: [10], bonus: [b1]), ..rest], 10 ->
          Ok(Game([Frame(rolls: [10], bonus: [b1, pins]), ..rest]))
        [Frame(rolls: [10], bonus: [_, _]), ..], 10 -> Error(GameComplete)
        [Frame(rolls: [r1, r2], bonus: []), ..rest], 10 if r1 + r2 == 10 ->
          Ok(Game([Frame(rolls: [r1, r2], bonus: [pins]), ..rest]))
        [Frame(rolls: [r1, r2], bonus: [_]), ..], 10 if r1 + r2 == 10 ->
          Error(GameComplete)
        [Frame(rolls: [r1, r2], bonus: []), ..rest], 10 if r1 + r2 == 10 ->
          Ok(Game([Frame(rolls: [r1, r2], bonus: [pins]), ..rest]))
        [Frame(rolls: [_, _], bonus: _), ..], 10 -> Error(GameComplete)
        [Frame(rolls: [10], bonus: _), Frame(rolls: [10], bonus: [pb1]), ..rest],
          _
        ->
          Ok(
            Game([
              Frame(rolls: [pins], bonus: []),
              Frame(rolls: [10], bonus: [pins]),
              Frame(rolls: [10], bonus: [pb1, pins]),
              ..rest
            ]),
          )
        [Frame(rolls: [10], bonus: _), ..rest], _ ->
          Ok(
            Game([
              Frame(rolls: [pins], bonus: []),
              Frame(rolls: [10], bonus: [pins]),
              ..rest
            ]),
          )
        [Frame(rolls: [r1], bonus: _), ..], _ if r1 + pins > 10 ->
          Error(InvalidPinCount)
        [Frame(rolls: [r1], bonus: _), Frame(rolls: [10], bonus: [pb1]), ..rest],
          _
        ->
          Ok(
            Game([
              Frame(rolls: [r1, pins], bonus: []),
              Frame(rolls: [10], bonus: [pb1, pins]),
              ..rest
            ]),
          )
        [Frame(rolls: [r1], bonus: _), ..rest], _ ->
          Ok(Game([Frame(rolls: [r1, pins], bonus: []), ..rest]))
        [Frame(rolls: [r1, r2], bonus: _), ..rest], _ if r1 + r2 == 10 ->
          Ok(
            Game([
              Frame(rolls: [pins], bonus: []),
              Frame(rolls: [r1, r2], bonus: [pins]),
              ..rest
            ]),
          )
        [Frame(rolls: [r1, r2], bonus: _), ..rest], _ ->
          Ok(
            Game([
              Frame(rolls: [pins], bonus: []),
              Frame(rolls: [r1, r2], bonus: []),
              ..rest
            ]),
          )
        _, _ -> panic as "Invalid Frame"
      }
  }
}

fn sum(list: List(Int)) -> Int {
  list.fold(list, 0, fn(sum, val) { sum + val })
}

pub fn score(game: Game) -> Result(Int, Error) {
  case list.length(game.frames) < 10 {
    True -> Error(GameNotComplete)
    False ->
      case game.frames {
        [Frame(rolls: [10], bonus: []), ..] -> Error(GameNotComplete)
        [Frame(rolls: [10], bonus: [10]), ..] -> Error(GameNotComplete)
        [Frame(rolls: [r1, r2], bonus: []), ..] if r1 + r2 == 10 ->
          Error(GameNotComplete)
        _ ->
          Ok(
            list.fold(game.frames, 0, fn(total, frame) {
              total + sum(frame.rolls) + sum(frame.bonus)
            }),
          )
      }
  }
}
