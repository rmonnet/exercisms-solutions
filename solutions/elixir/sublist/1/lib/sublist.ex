defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(l1, l2) do
    cond do
      length(l1) < length(l2) -> if(is_sublist(l1,l2), do: :sublist, else: :unequal)
      length(l1) == length(l2) -> if(is_equal(l1, l2), do: :equal, else: :unequal)
      true -> if(is_sublist(l2, l1), do: :superlist, else: :unequal)
    end
  end
  
  def is_equal([], []), do: true
  def is_equal([x|r1], [x|r2]), do: is_equal(r1,r2)
  def is_equal(_, _), do: false

  def is_sublist([], _), do: true
  # The second clause is necessary for the cases such as is_sublist([1,2,5], [1,2,3,1,2,5])
  def is_sublist(l1=[x|r1], [x|r2]), do: start_with(r1, r2) or (length(l1) <= length(r2) and is_sublist(l1, r2))
  def is_sublist(l1, [_|r2]), do: if(length(r2)<length(l1), do: false, else: is_sublist(l1,r2))
  def is_sublist(_, _), do: false

  def start_with([], _), do: true
  def start_with([x|r1], [x|r2]), do: start_with(r1, r2)
  def start_with(_, _), do: false

end
