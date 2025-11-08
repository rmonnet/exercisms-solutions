fn is_multiple(n: Int, m: Int) -> Bool {
  n % m == 0
}
pub fn is_leap_year(year: Int) -> Bool {
  is_multiple(year, 4) && {!is_multiple(year, 100) || is_multiple(year, 400)}
}
