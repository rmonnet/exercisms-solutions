defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    cond do
      size <= 0 -> []
      String.length(s) < size -> []
      true ->
          n = String.length(s) - size + 1
          Enum.map(0..n-1, fn i -> String.slice(s, i, size) end)
    end
  end
end
