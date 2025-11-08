defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}
  
    ## Examples
  
      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}
  
      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}
  
  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coins, target) do
    # First compute the greedy solution as an upperbound on the number of coins in the solution,
    # then use the recursive solution but give up as soon as the number of coins exceed the greedy solution.
    # If there is no greedy solution, we can still bound with ceiling(target/smallest coin).
    possible_coins = coins |> Enum.filter(&(&1 <= target)) |> Enum.reverse()
    {greedy_status, greedy_solution} = greedy(possible_coins, target, [])

    if greedy_status == :error do
      dynamic(possible_coins, target, [], ceil(target / List.first(coins, 1)))
    else
      dynamic(possible_coins, target, [], length(greedy_solution))
    end
  end

  defp greedy(_coins, 0, given), do: {:ok, given}
  defp greedy([], _target, _given), do: {:error, "cannot change"}

  defp greedy(coins = [first_coin | other_coins], target, given) do
    if first_coin > target do
      greedy(other_coins, target, given)
    else
      greedy(coins, target - first_coin, [first_coin | given])
    end
  end

  defp dynamic(_coins, 0, given, _max), do: {:ok, given}
  defp dynamic([], _target, _given, _max), do: {:error, "cannot change"}

  defp dynamic(_coins, _target, given, max) when length(given) >= max,
    do: {:error, "cannot change"}

  defp dynamic(coins = [first_coin | other_coins], target, given, max) do
    if first_coin > target do
      dynamic(other_coins, target, given, max)
    else
      best_solution(
        dynamic(other_coins, target, given, max),
        dynamic(coins, target - first_coin, [first_coin | given], max)
      )
    end
  end

  defp best_solution(sol1 = {status1, given1}, sol2 = {status2, given2}) do
    cond do
      status1 == :error -> sol2
      status2 == :error -> sol1
      true -> if(length(given1) < length(given2), do: sol1, else: sol2)
    end
  end
end
