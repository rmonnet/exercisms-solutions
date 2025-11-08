import gleam/option.{type Option, Some, None}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  case player.name {
    Some(name) -> name
    None -> "Mighty Magician"
  }
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health <= 0, player.level >= 10 {
    True, False -> Some(Player(..player, health: 100))
    True, True -> Some(Player(..player, health:100, mana: Some(100)))
    False, _ -> None
  }
}

fn max(a: Int, b: Int) -> Int {
  case a < b {
    True -> b
    False -> a
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana {
    None -> #(Player(..player, health: max(player.health - cost, 0)), 0)
    Some(mana) if cost <= mana -> #(Player(..player, mana: Some(mana - cost)), 2*cost)
    Some(_) -> #(player, 0)
  }
}
