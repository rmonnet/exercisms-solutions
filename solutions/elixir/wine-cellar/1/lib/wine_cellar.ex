defmodule WineCellar do
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter([], _, _), do: []
  def filter([{k,v}|rest], color, opts \\ []) do
    {type, year, country} = v
    selected_year = Keyword.get(opts, :year)
    selected_country = Keyword.get(opts, :country)
    if k == color and
      ((selected_year == nil) or (year == selected_year)) and
      ((selected_country == nil) or (country == selected_country)) do
        [v | filter(rest, color, opts)]
    else
      filter(rest, color, opts)
    end
  end

  # The functions below do not need to be modified.

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
