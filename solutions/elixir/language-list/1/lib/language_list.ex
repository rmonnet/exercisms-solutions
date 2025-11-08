defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove(list) do
    [_ | rest] = list
    rest
  end

  def first(list) do
    [first | _] = list
    first
  end

  def count(list) do
    length(list)
  end

  def functional_list?(list) do
    non_functionals = list -- ["Clojure", "Haskell", "Erlang", "F#", "Elixir"]
    length(list) > length(non_functionals)
  end
end
