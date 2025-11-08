defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(l1, l2) do
    cond do
      length(l1) < length(l2) -> if(sublist?(l1,l2), do: :sublist, else: :unequal)
      length(l1) == length(l2) -> if(equal?(l1, l2), do: :equal, else: :unequal)
      true -> if(sublist?(l2, l1), do: :superlist, else: :unequal)
    end
  end
  
  defp equal?([], []), do: true
  defp equal?([x|r1], [x|r2]), do: equal?(r1,r2)
  defp equal?(_, _), do: false

  defp sublist?([], _), do: true
  # The second clause is necessary for the cases such as sublist?([1,2,5], [1,2,3,1,2,5])
  defp sublist?(l1=[x|r1], [x|r2]), do: start_with?(r1, r2) or (length(l1) <= length(r2) and sublist?(l1, r2))
  defp sublist?(l1, [_|r2]), do: if(length(r2)<length(l1), do: false, else: sublist?(l1,r2))
  defp sublist?(_, _), do: false

  defp start_with?([], _), do: true
  defp start_with?([x|r1], [x|r2]), do: start_with?(r1, r2)
  defp start_with?(_, _), do: false

end
