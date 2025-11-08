pub fn is_armstrong_number(num: u32) -> bool {
    let digits = format!("{}", num);
    let len = digits.len() as u32;
    let sum_digits = 
        digits.chars().map(|c| (c.to_digit(10).unwrap()).pow(len) as u128).sum::<u128>();
    (num as u128) == sum_digits
}
