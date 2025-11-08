type nucleotide = A | C | G | T

let hamming_distance a b =
  match (List.length a, List.length b) with
    | (0, lb) when lb <> 0 -> Error "left strand must not be empty"
    | (la, 0) when la <> 0 -> Error "right strand must not be empty"
    | (la, lb) when la <> lb -> Error "left and right strands must be of equal length"
    | _ -> Ok (List.fold_left (+) 0 (List.map2 (fun x y -> if x <> y then 1 else 0) a b))
