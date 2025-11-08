pub fn convert(number: Int) -> String {
  case number {
    num if num >= 1000 -> "M"  <> convert(num - 1000)
    num if num >= 900  -> "CM" <> convert(num - 900)
    num if num >= 500  -> "D"  <> convert(num - 500)
    num if num >= 400  -> "CD" <> convert(num - 400)
    num if num >= 100  -> "C"  <> convert(num - 100)
    num if num >= 90   -> "XC" <> convert(num - 90)
    num if num >= 50   -> "L"  <> convert(num - 50)
    num if num >= 40   -> "XL" <> convert(num - 40)
    num if num >= 10   -> "X"  <> convert(num - 10)
    num if num >= 9    -> "IX" <> convert(num - 9)
    num if num >= 5    -> "V"  <> convert(num - 5)
    num if num >= 4    -> "IV" <> convert(num - 4)
    num if num >= 1    -> "I"  <> convert(num - 1)
    _                  -> ""
  }
}
