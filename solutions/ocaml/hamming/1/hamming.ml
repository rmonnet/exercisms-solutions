type nucleotide = A | C | G | T

let rec distance a b acc =
  match (a, b) with
  | ([], []) ->
    Ok acc
  | (x::xs, y::ys) ->
    if x = y
      then distance xs ys acc
      else distance xs ys (acc + 1)
  | _ -> assert false (* we already checked that the lists have equal length *)

let hamming_distance a b =
  let la = List.length a in
  let lb = List.length b in
    if la = 0 && lb <> 0
      then Error "left strand must not be empty"
    else if la <> 0 && lb = 0
      then Error "right strand must not be empty"
    else if la <> lb
      then Error "left and right strands must be of equal length"
    else distance a b 0
