defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      String.trim(input) == "" ->
        "Fine. Be that way!"

      yelling?(input) and question?(input) ->
        "Calm down, I know what I'm doing!"

      yelling?(input) ->
        "Whoa, chill out!"

      question?(input) ->
        "Sure."

      true ->
        "Whatever."
    end
  end

  defp yelling?(sentence),
    do: String.upcase(sentence) == sentence and String.match?(sentence, ~r/[[:alpha:]]/u)

  defp question?(sentence), do: String.trim(sentence) |> String.ends_with?("?")
end
