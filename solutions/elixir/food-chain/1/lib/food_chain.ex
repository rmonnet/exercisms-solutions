defmodule FoodChain do

  @animals ["fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse"]

  @exclamations [
    "It wriggled and jiggled and tickled inside her.",
    "How absurd to swallow a bird!",
    "Imagine that, to swallow a cat!",
    "What a hog, to swallow a dog!",
    "Just opened her throat and swallowed a goat!",
    "I don't know how she swallowed a cow!",
  ]
  @doc """
  Generate consecutive verses of the song 'I Know an Old Lady Who Swallowed a Fly'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    start..stop |> Enum.map(&verse/1) |> Enum.join("\n")
  end

  defp verse(number) do
    ["I know an old lady who swallowed a #{Enum.at(@animals, number-1)}.",
    comment(number),
    swallowing_phrase(number),
    last_sentence(number)
    ]
    |> List.flatten
    |> Enum.reject(&(String.length(&1) == 0))
    |> Enum.join("\n")
  end

  defp comment(number) when number < 2 or number >= 8, do: ""
  defp comment(number), do: Enum.at(@exclamations, number - 2)

  defp swallowing_phrase(number) when number < 2 or number >= 8, do: ""
  defp swallowing_phrase(number) do
      (number - 2)..0 |> Enum.map(fn n ->
        if n == 1 do
          "She swallowed the #{Enum.at(@animals, n+1)} to catch the spider that wriggled and jiggled and tickled inside her."
        else
          "She swallowed the #{Enum.at(@animals, n+1)} to catch the #{Enum.at(@animals, n)}."
        end
      end)
  end

  defp last_sentence(number) do
    if number == 8 do
      "She's dead, of course!\n"
    else
      "I don't know why she swallowed the fly. Perhaps she'll die.\n"
    end
  end

end
