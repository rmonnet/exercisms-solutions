open Base

let empty = Map.empty (module Char)

let count_nucleotide s c =
  match c with
  | 'A' | 'C' | 'G' | 'T' ->
    String.fold_result s ~init:0
    ~f:(fun acc x -> match x  with
      | n when n == c -> Ok (acc + 1)
      | 'A' | 'C' | 'G' | 'T' -> Ok acc
      | _ -> Error x)
  | _ -> Error c

let count_nucleotides s =
  let individual_counts =
    List.fold_result ['A'; 'C'; 'G'; 'T'] ~init:[] 
      ~f:(fun acc x -> match (count_nucleotide s x) with
          | Error x -> Error x
          | Ok count -> Ok ((x, count)::acc))
  in
    match individual_counts with
    | Error x -> Error x
    | Ok counts ->
      Ok (List.fold counts ~init:empty
        ~f:(fun acc (n, c) ->
          (if c > 0 then (Map.set acc ~key:n ~data:c) else acc)))
