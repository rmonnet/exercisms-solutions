import gleam/list

pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(pizza: Pizza)
  ExtraToppings(pizza: Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  case pizza {
    Margherita -> 7
    Caprese -> 9
    Formaggio -> 10
    ExtraSauce(p) -> 1 + pizza_price(p)
    ExtraToppings(p) -> 2 + pizza_price(p)
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  let extra_fee = case list.length(order) {
    1 -> 3
    2 -> 2
    _ -> 0
  }
  order_price_loop(extra_fee, order)
}

fn order_price_loop(acc: Int, order: List(Pizza)) -> Int {
  case order {
    [] -> acc
    [first, ..rest] -> order_price_loop(acc + pizza_price(first), rest)
  }
}
