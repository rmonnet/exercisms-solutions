defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1[:price]), :asc)
  end

  def with_missing_price([]), do: []

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1[:price]==nil))
  end

  def update_names([], _old_word, _new_word), do: []

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn product ->
      Map.update(product, :name, "", &(String.replace(&1, old_word, new_word)))
      end)
  end

  def increase_quantity(item, count) do
    updated_quantities = 
      for {k, v} <- item[:quantity_by_size], do: {k, v + count}
    Map.put(item, :quantity_by_size, Map.new(updated_quantities))
  end

  def total_quantity(item) do
    quantities = item[:quantity_by_size]
    Enum.reduce(Map.keys(quantities), 0, &(quantities[&1]+&2))
  end
end
