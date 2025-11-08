import gleam/list

pub fn place_location_to_treasure_location(
  place_location: #(String, Int),
) -> #(Int, String) {
  let #(letter, digit) = place_location
  #(digit, letter)
}

pub fn treasure_location_matches_place_location(
  place_location: #(String, Int),
  treasure_location: #(Int, String),
) -> Bool {
  treasure_location == place_location_to_treasure_location(place_location)
}

pub fn count_place_treasures(
  place: #(String, #(String, Int)),
  treasures: List(#(String, #(Int, String))),
) -> Int {
  let location = place_location_to_treasure_location(place.1)
  list.filter(treasures, keeping: fn(treasure) { treasure.1 == location })
  |> list.length()
}

pub fn special_case_swap_possible(
  found_treasure: #(String, #(Int, String)),
  place: #(String, #(String, Int)),
  desired_treasure: #(String, #(Int, String)),
) -> Bool {
  let found = found_treasure.0
  let desired = desired_treasure.0
  case place.0 {
    "Abandoned Lighthouse" if found == "Brass Spyglass" -> True
    "Stormy Breakwater" if found == "Amethyst Octopus"
      && {desired == "Crystal Crab" || desired == "Glass Starfish"} -> True
    "Harbor Managers Office" if found == "Vintage Pirate Hat"
      && {desired == "Model Ship in Large Bottle"
      || desired == "Antique Glass Fishnet Float"} -> True
    _ -> False
  }
}
