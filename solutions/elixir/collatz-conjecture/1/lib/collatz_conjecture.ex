defmodule CollatzConjecture do

  defp step(1, nsteps), do: nsteps
  defp step(input, nsteps) when rem(input,2) == 0, do: step(div(input, 2), nsteps+1)
  defp step(input, nsteps), do: step(3*input+1, nsteps+1)

  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_integer(input) and input > 0 do
    step(input, 0)
  end
end
