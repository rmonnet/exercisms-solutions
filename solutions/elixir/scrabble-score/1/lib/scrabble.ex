defmodule Scrabble do

  @letter_scores [{"AEIOULNRST", 1}, {"DG", 2}, {"BCMP", 3}, {"FHVWY", 4},
          {"K", 5}, {"JX", 8}, {"QZ", 10}]

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase
    |> String.graphemes
    |> Enum.reduce(0, fn (letter, acc) -> acc + letter_score(letter) end)
  end

  defp letter_score(letter) do
    {_, value} = Enum.find(@letter_scores, {[], 0}, fn {letters, _} ->
        String.contains?(letters, letter)
      end)
    value
  end
end
