defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer

  def maximum_value(items, maximum_weight) do
    knapsack(items, maximum_weight, length(items))
  end

  defp value_of(items, n), do: Enum.at(items, n)[:value]

  defp weight_of(items, n), do: Enum.at(items, n)[:weight]

  defp knapsack(_, 0, _), do: 0

  defp knapsack(_, _, 0), do: 0

  defp knapsack(items, max_weight, n) do
    if weight_of(items, n-1) > max_weight do
      knapsack(items, max_weight, n-1)
    else
      max(
        value_of(items, n-1) + knapsack(items, max_weight - weight_of(items, n-1), n-1),
        knapsack(items, max_weight, n-1))
    end
  end

end
