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
  case order {
    [] -> 0
    [first] -> 3 + pizza_price(first)
    [first, second] -> 2 + pizza_price(first) + pizza_price(second)
    _ -> order_price_loop(0, order)
  }
}

fn order_price_loop(acc: Int, order: List(Pizza)) -> Int {
  case order {
    [] -> acc
    [first, ..rest] -> {
      let acc = acc + pizza_price(first)
      order_price_loop(acc, rest)
    }
  }
}
