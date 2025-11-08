defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))

  def matrix(0), do: []

  def matrix(n) do
    # Keep track of index (matrix as a flat array) i, row r, column c, index limits,
    # and direction of travel to compute the consecutive values in the spiral.
    # once we get the values, we rearange them in order of matrix index (row after row).
    Stream.unfold({0, 0, 0, boundaries(n), :right}, fn {i, r, c, limits = [first | rest], dir} ->
      case dir do
        :right ->
          new_dir = if(i < first, do: :right, else: :down)
          new_limits = if(i < first, do: limits, else: rest)
          new_r = if(i < first, do: r, else: r + 1)
          new_c = if(i < first, do: c + 1, else: c)
          {{r * n + c, i}, {i + 1, new_r, new_c, new_limits, new_dir}}

        :down ->
          new_dir = if(i < first, do: :down, else: :left)
          new_limits = if(i < first, do: limits, else: rest)
          new_r = if(i < first, do: r + 1, else: r)
          new_c = if(i < first, do: c, else: c - 1)
          {{r * n + c, i}, {i + 1, new_r, new_c, new_limits, new_dir}}

        :left ->
          new_dir = if(i < first, do: :left, else: :up)
          new_limits = if(i < first, do: limits, else: rest)
          new_r = if(i < first, do: r, else: r - 1)
          new_c = if(i < first, do: c - 1, else: c)
          {{r * n + c, i}, {i + 1, new_r, new_c, new_limits, new_dir}}

        :up ->
          new_dir = if(i < first, do: :up, else: :right)
          new_limits = if(i < first, do: limits, else: rest)
          new_r = if(i < first, do: r - 1, else: r)
          new_c = if(i < first, do: c, else: c + 1)
          {{r * n + c, i}, {i + 1, new_r, new_c, new_limits, new_dir}}
      end
    end)
    |> Enum.take(n * n)
    |> Enum.sort(fn {a, _}, {b, _} -> a < b end)
    |> Enum.map(fn {_, i} -> i + 1 end)
    |> Enum.chunk_every(n)
  end

  # Compute the flat array indexes where we need to change direction to follow a spiral.
  defp boundaries(n) do
    Stream.unfold(0, fn i ->
      i_over_2 = div(i, 2)

      if rem(i, 2) == 0 do
        {(i + 1) * n - i_over_2 * (i_over_2 + 1) - 1, i + 1}
      else
        {(i + 1) * n - (i_over_2 + 1) * (i_over_2 + 1) - 1, i + 1}
      end
    end)
    |> Enum.take(2 * n - 1)
  end
end
