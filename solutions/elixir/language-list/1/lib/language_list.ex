defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove(list) do
    tl(list)
  end

  def first(list) do
    hd(list)
  end

  def count([]), do: 0

  def count(list) do
    1 + count(tl(list))
  end

  def functional_list?(list) do
    "Elixir" in list
  end
end
