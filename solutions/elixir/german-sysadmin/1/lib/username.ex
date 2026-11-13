defmodule Username do
  def sanitize([]), do: []

  def sanitize(username) do
    [first | rest] = username

    case first do
      first when first in ?a..?z ->
        [first | sanitize(rest)]

      first
      when first == ?ä ->
        [?a, ?e | sanitize(rest)]

      first
      when first == ?ö ->
        [?o, ?e | sanitize(rest)]

      first
      when first == ?ü ->
        [?u, ?e | sanitize(rest)]

      first
      when first == ?ß ->
        [?s, ?s | sanitize(rest)]

      first
      when first == ?_ ->
        [?_ | sanitize(rest)]

      _ ->
        sanitize(rest)
    end
  end
end
