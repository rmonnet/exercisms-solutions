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
  def search(numbers, key) do
    binary_search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  defp binary_search(_, _, first_index, last_index) when last_index < first_index, do: :not_found

  defp binary_search(numbers, key, first_index, last_index) do
    mid_index = first_index + div(last_index - first_index, 2)
    mid_element = elem(numbers, mid_index)

    cond do
      key == mid_element -> {:ok, mid_index}
      key < mid_element -> binary_search(numbers, key, first_index, mid_index - 1)
      key > mid_element -> binary_search(numbers, key, mid_index + 1, last_index)
    end
  end
end
