defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  def recite(strings=[first|others]) do
    sentences = Enum.zip(strings, others)
        |> Enum.map(fn {f,s} -> "For want of a #{f} the #{s} was lost." end)
    Enum.join(sentences ++ ["And all for the want of a #{first}.\n"], "\n")
  end
end
