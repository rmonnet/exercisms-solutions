defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      String.trim(input) == "" ->
        "Fine. Be that way!"

      is_yelling?(input) and is_question?(input) ->
        "Calm down, I know what I'm doing!"

      is_yelling?(input) ->
        "Whoa, chill out!"

      is_question?(input) ->
        "Sure."

      true ->
        "Whatever."
    end
  end

  defp is_yelling?(sentence),
    do: String.upcase(sentence) == sentence and String.match?(sentence, ~r/[[:alpha:]]/u)

  defp is_question?(sentence), do: String.trim(sentence) |> String.ends_with?("?")
end
