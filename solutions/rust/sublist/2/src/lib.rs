#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq>(first_list: &[T], second_list: &[T]) -> Comparison {
    let first_len = first_list.len();
    let second_len = second_list.len();

    if first_len == second_len {
        // only possibility is equal or unequal
        if *first_list == *second_list {
            return Comparison::Equal;
        }
    } else if first_len < second_len {
        // only possibility is sublist or unequal
        let num_to_drop = second_len - first_len;
        for i in 0..=num_to_drop {
            if second_list[i..second_len-num_to_drop+i] == *first_list {
                return Comparison::Sublist;
            }
        }
    } else {
        // only possibility is superlist or unequal
        
        let num_to_drop = first_len - second_len;
        for i in 0..=num_to_drop {
            if first_list[i..first_len-num_to_drop+i] == *second_list {
                return Comparison::Superlist;
            }
        }
    }
    // not equal, sublist or superlist, only remaining possibility is ...
    Comparison::Unequal
}
