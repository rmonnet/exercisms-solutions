defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    ordered_base = reorder(base)
    down_base = String.downcase(base)
    candidates
      |> Enum.filter(&(reorder(&1) == ordered_base))
      |> Enum.filter(&(String.downcase(&1) != down_base))
  end

  defp different(word1, word2) do
    String.downcase(word1) != String.downcase(word2)
  end

  defp reorder(word) do
    word |> String.downcase |> String.graphemes |> Enum.sort |> Enum.join
  end
end
