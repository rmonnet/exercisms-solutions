defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    guess(radicand, radicand)
  end

  defp guess(n, x) do
    root = 0.5 * (x + (n / x))
    if root*root==n do
      root
    else
      guess(n, root)
    end
  end
end
