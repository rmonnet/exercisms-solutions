func protectSecret(_ secret: String, withPassword password: String) -> (String) -> String {
  
  func recoverSecret(_ pwd: String) -> String {
    if pwd == password {
      return secret 
    } else {
      return  "Sorry. No hidden secrets here."
    }
  }
  return recoverSecret
}

func generateCombination(forRoom room: Int, usingFunction f: (Int) -> Int) -> (Int, Int, Int) {
  let firstNumber = f(room)
  let secondNumber = f(firstNumber)
  let thirdNumber = f(secondNumber)
  return (firstNumber, secondNumber, thirdNumber)

}
