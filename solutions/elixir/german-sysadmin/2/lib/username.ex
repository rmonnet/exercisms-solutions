defmodule Username do

  def sanitize([]), do: []

  def sanitize([first|rest]) do
    case first do
      x when ?a <= x and x <= ?z -> [x | sanitize(rest)]
      ?_ -> [?_ | sanitize(rest)]
      ?ä -> [?a, ?e | sanitize(rest)]
      ?ö -> [?o, ?e | sanitize(rest)]
      ?ü -> [?u, ?e | sanitize(rest)]
      ?ß -> [?s, ?s | sanitize(rest)]
      _ -> sanitize(rest)
    end
  end

end
