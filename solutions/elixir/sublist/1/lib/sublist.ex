defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    len_a = length(a)
    len_b = length(b)

    cond do
      len_a < len_b ->
        if includes?(b, a), do: :sublist, else: :unequal

      len_a == len_b ->
        if includes?(a, b), do: :equal, else: :unequal

      len_a > len_b ->
        if includes?(a, b), do: :superlist, else: :unequal
    end
  end

  # In compare_front a is always the smallest list.
  defp includes?([], []), do: true
  defp includes?([], _), do: false
  defp includes?(_, []), do: true

  defp includes?([first | a], [first | b]) do
    if start_with([first | a], [first | b]) do
      true
    else
      includes?(a, [first | b])
    end
  end

  defp includes?([_ | a], b), do: includes?(a, b)

  defp start_with(_, []), do: true
  defp start_with([first | a], [first | b]), do: start_with(a, b)
  defp start_with(_, _), do: false
end
