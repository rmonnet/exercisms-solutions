
const inner_rad_sq = 1.
const middle_rad_sq = 25.
const outer_rad_squ = 100.

pub fn score(x: Float, y: Float) -> Int {
  case x *. x +. y *. y {
    rad_sq if rad_sq <=. inner_rad_sq -> 10
    rad_sq if rad_sq <=. middle_rad_sq -> 5
    rad_sq if rad_sq <=. outer_rad_squ -> 1
    _ -> 0
  }  
}
