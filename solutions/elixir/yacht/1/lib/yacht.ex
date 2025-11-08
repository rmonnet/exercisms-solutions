defmodule Yacht do
  @type category ::
          :ones
          | :twos
          | :threes
          | :fours
          | :fives
          | :sixes
          | :full_house
          | :four_of_a_kind
          | :little_straight
          | :big_straight
          | :choice
          | :yacht

  @doc """
  Calculate the score of 5 dice using the given category's scoring method.
  """
  @spec score(category :: category(), dice :: [integer]) :: integer
  def score(:ones, rolls), do: count(1, rolls)

  def score(:twos, rolls), do: 2 * count(2, rolls)

  def score(:threes, rolls), do: 3 * count(3, rolls)

  def score(:fours, rolls), do: 4 * count(4, rolls)

  def score(:fives, rolls), do: 5 * count(5, rolls)

  def score(:sixes, rolls), do: 6 * count(6, rolls)

  def score(:yacht, rolls) do
    [{value, count} | _] = frequencies(rolls)
    if(count == 5, do: 50, else: 0)
  end

  def score(:full_house, rolls) do
    case frequencies(rolls) do
      [{value1, count1}, {value2, count2} | _] ->
        if(count1 == 3 and count2 == 2, do: 3*value1+2*value2, else: 0)
      _ -> 0
    end
  end

  def score(:four_of_a_kind, rolls) do
    [{value, count} | _] = frequencies(rolls)
    if(count >= 4, do: 4 * value, else: 0)
  end

  def score(:little_straight, rolls) do
    if(Enum.sort(rolls, :asc) == [1, 2, 3, 4, 5], do: 30, else: 0)
  end

  def score(:big_straight, rolls) do
    if(Enum.sort(rolls, :asc) == [2, 3, 4, 5, 6], do: 30, else: 0)
  end

  def score(:choice, rolls) do
    Enum.reduce(rolls, 0, &(&1+&2))
  end

def score(_, _), do: 0

  defp count(value, rolls), do:  length(Enum.filter(rolls, &(&1 == value)))

  defp frequencies(rolls) do
    Enum.reduce(rolls, %{}, fn (value, freqs) ->
      Map.update(freqs, value, 1, &(&1+1)) end)
    |> Enum.map(fn {value, count} -> {value, count} end)
    |> Enum.sort(fn ({_, c1}, {_, c2}) -> c1 > c2 end)
  end

end
