pub type TreasureChest(a) {
  TreasureChest(password: String, content: a)
}

pub type UnlockResult(a) {
  Unlocked(content: a)
  WrongPassword
}

pub fn get_treasure(
  chest: TreasureChest(treasure),
  password: String,
) -> UnlockResult(treasure) {
  case chest.password {
    pwd if pwd == password -> Unlocked(chest.content)
    _ -> WrongPassword
  }
}
