defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    d2 = dist_sq(x, y)

    cond do
      d2 <= 1 -> 10
      d2 <= 25 -> 5
      d2 <= 100 -> 1
      true -> 0
    end
  end

  defp dist_sq(x, y), do: x * x + y * y
end
