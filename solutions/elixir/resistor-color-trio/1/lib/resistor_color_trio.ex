defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohms from resistor colors
  """

  @values %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    [band1, band2, zeros | _] = Enum.map(colors, &Map.get(@values, &1))
    value = (10 * band1 + band2) * 10 ** zeros
    normalize(value)
  end

  @kilo 1_000
  @mega 1_000_000
  @giga 1_000_000_000

  def normalize(value) do
    cond do
      value > @giga -> {div(value, @giga), :gigaohms}
      value > @mega -> {div(value, @mega), :megaohms}
      value > @kilo -> {div(value, @kilo), :kiloohms}
      true -> {value, :ohms}
    end
  end
end
