let birthday = "Birthday"

let valentine = "Valentine's Day"

let anniversary = "Anniversary"

// TODO: define the 'space' Character constant
let space : Character = " "

// TODO: define the 'exclamation' Character constant
let exclamation : Character = "!"

func buildSign(for occasion: String, name: String) -> String {
  return "Happy \(occasion) \(name)!"
}

func graduationFor(name: String, year: Int) -> String {
  return "Congratulations \(name)!\nClass of \(year)"
}

func costOf(sign: String) -> Int {
  return 20 + 2 * sign.count
}
