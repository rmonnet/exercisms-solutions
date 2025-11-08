defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label([first, second, third | _]) do
    resistance = (10 * value(first) + value(second)) * 10**value(third)
    if resistance > 1000 do
      {resistance/1000, :kiloohms}
    else
      {resistance, :ohms}
    end
  end

  defp value(color) do
    case color do
      :black -> 0
      :brown -> 1
      :red -> 2
      :orange -> 3
      :yellow -> 4
      :green -> 5
      :blue -> 6
      :violet -> 7
      :grey -> 8
      :white -> 9
    end
  end
end
