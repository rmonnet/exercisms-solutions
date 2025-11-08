defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer

  def maximum_value(items, maximum_weight) do
    knapsack(items, maximum_weight)
  end

  defp knapsack(_, 0), do: 0

  defp knapsack([], _), do: 0

  defp knapsack([item | rest], max_weight) do
    if item[:weight] > max_weight do
      knapsack(rest, max_weight)
    else
      max(
        item[:value] + knapsack(rest, max_weight - item[:weight]),
        knapsack(rest, max_weight))
    end
  end

end
