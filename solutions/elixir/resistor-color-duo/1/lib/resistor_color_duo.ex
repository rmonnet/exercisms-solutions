defmodule ResistorColorDuo do
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

  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value(colors) do
    [band1, band2 | _] = Enum.map(colors, &Map.fetch!(@values, &1))
    10 * band1 + band2
  end
end
