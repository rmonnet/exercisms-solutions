pub fn reverse(input: &str) -> String {
    let mut chars: Vec<char> = vec![];
    for c in input.chars().rev() {
        chars.push(c);
    }
    chars.into_iter().collect()
}
