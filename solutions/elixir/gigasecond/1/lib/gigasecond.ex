defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    {:ok, moment} = NaiveDateTime.new(year, month, day, hours, minutes, seconds)
    NaiveDateTime.add(moment, 1_000_000_000, :second)
    |> NaiveDateTime.to_erl()
    
  end
end
