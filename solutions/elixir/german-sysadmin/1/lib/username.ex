defmodule Username do

  def sanitize([]), do: []

  def sanitize([first|rest])
  when (first == ?_) or (?a <= first and first <= ?z) do
    [first|sanitize(rest)]
  end

  def sanitize([?ä|rest]), do: [?a, ?e | sanitize(rest)]

  def sanitize([?ö|rest]), do: [?o, ?e | sanitize(rest)]

  def sanitize([?ü|rest]), do: [?u, ?e | sanitize(rest)]

  def sanitize([?ß|rest]), do: [?s, ?s | sanitize(rest)]

  def sanitize([_|rest]), do: sanitize(rest)

    # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss

end
