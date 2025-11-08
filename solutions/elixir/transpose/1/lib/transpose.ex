defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples

    iex> Transpose.transpose("ABC\\nDE")
    "AD\\nBE\\nC"

    iex> Transpose.transpose("AB\\nDEF")
    "AD\\nBE\\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    String.split(input, "\n")
    |> Enum.map(&String.graphemes/1)
    |> flip([])
    |> Enum.join("\n")
  end

  defp flip(rows, acc) do
    if all_empty?(rows) do
      Enum.reverse(acc)
    else
      new_row = rows |> take_firsts |> custom_join([])
      flip(drop_firsts(rows), [new_row | acc])
    end
  end

  defp take_firsts(rows), do: Enum.map(rows, &(Enum.take(&1, 1)))

  defp drop_firsts(rows), do: Enum.map(rows, &(Enum.drop(&1, 1)))

  defp all_empty?([]), do: true
  defp all_empty?([first | rest]), do: Enum.empty?(first) and all_empty?(rest)

  defp custom_join([], acc), do: acc |> Enum.reverse |> Enum.join
  defp custom_join(list=[first | rest], acc) do
    if all_empty?(list) do
      acc |> Enum.reverse |> Enum.join
    else
      custom_join(rest, [if(Enum.empty?(first), do: " ", else: first) | acc])
    end
  end
end
