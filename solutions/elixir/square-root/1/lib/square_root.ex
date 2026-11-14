defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    guess(radicand, 0, radicand + 1)
  end

  defp guess(_, lower, upper) when upper == lower + 1, do: lower

  defp guess(value, lower, upper) do
    mid = div(lower + upper, 2)

    if mid * mid <= value do
      guess(value, mid, upper)
    else
      guess(value, lower, mid)
    end
  end
end
