defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      String.match?(input, ~r/^\s*$/)                 -> "Fine. Be that way!"
      String.match?(input, ~r/[[:upper:]].*\?\s*$/)
        and String.upcase(input) == input             -> "Calm down, I know what I'm doing!" 
      String.match?(input, ~r/[[:upper:]]/)
        and String.upcase(input) == input             -> "Whoa, chill out!" 
      String.match?(input, ~r/\?\s*$/)                -> "Sure."
      true                                            -> "Whatever."
    end
  end
end
