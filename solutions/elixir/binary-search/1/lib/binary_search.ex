defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _), do: :not_found
  def search(numbers, key) do
    split(numbers, key, 0, tuple_size(numbers)-1)
  end

  # We have reached a single value, no need to iterate anymore.
  defp split(tuple, value, index, index) do
    if(elem(tuple, index) == value, do: {:ok, index}, else: :not_found)
  end

  # We have run out of values to check.
  defp split(_, _, start, stop) when stop < start, do: :not_found

  # Check the middle value and select the lower or upper part unless
  # the value matches.
  defp split(tuple, val, start, stop) do
    middle = div(start + stop, 2)
    middle_val = elem(tuple, middle)
    cond do
      middle_val == val -> {:ok, middle}
      middle_val > val -> split(tuple, val, start, middle - 1)
      true -> split(tuple, val, middle + 1, stop)
    end
  end
end
