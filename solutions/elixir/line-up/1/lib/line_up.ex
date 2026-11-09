defmodule LineUp do
  @doc """
  Formats a full ticket sentence for the given name and number, including
  the person's name, the ordinal form of the number, and fixed descriptive text.
  """
  @spec format(name :: String.t(), number :: pos_integer()) :: String.t()
  def format(name, number) do
    "#{name}, you are the #{number_with_suffix(number)} customer we serve today. Thank you!"
  end

  defp number_with_suffix(number) do
    number_as_str = "#{number}"

    number_as_str <>
      cond do
        String.ends_with?(number_as_str, "11") or String.ends_with?(number_as_str, "12") or
            String.ends_with?(number_as_str, "13") ->
          "th"

        String.ends_with?(number_as_str, "1") ->
          "st"

        String.ends_with?(number_as_str, "2") ->
          "nd"

        String.ends_with?(number_as_str, "3") ->
          "rd"

        true ->
          "th"
      end
  end
end
