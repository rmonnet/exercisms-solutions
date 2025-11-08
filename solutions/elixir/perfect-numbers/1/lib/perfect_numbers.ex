defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}

  def classify(number) when not is_integer(number), do: {:error, "not an integer"}

  def classify(number) when number <= 0, do: {:error, "Classification is only possible for natural numbers."}

  def classify(1), do: {:ok, :deficient}

  def classify(number) do
    sum_factors = 1..(number-1)
      |> Enum.reduce(0, fn (p,acc) -> if(rem(number, p) == 0, do: p+acc, else: acc) end)

    cond do
      sum_factors == number -> {:ok, :perfect}
      sum_factors > number -> {:ok, :abundant}
      sum_factors < number -> {:ok, :deficient}
    end
  end

end
