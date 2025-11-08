pub type TreasureChest(treasure) {
  TreasureChest(password: String, content: treasure)
}

pub type UnlockResult(treasure) {
  Unlocked(content: treasure)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  password: String,
) -> UnlockResult(treasure) {
  case chest.password == password {
    True -> Unlocked(chest.content)
    False -> WrongPassword
  }
}
