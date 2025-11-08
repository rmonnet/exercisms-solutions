defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(~r/[\s-]+/)
    |> Enum.map(&(&1 |> String.replace(~r/_/, "") |> String.at(0) |> String.upcase))
    |> Enum.join
  end
end
