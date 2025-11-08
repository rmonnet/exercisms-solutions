defmodule Tournament do

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
      title = "Team                           | MP |  W |  D |  L |  P"
      score_board = Enum.reduce(input, %{}, fn (game, scores) ->
          game_elements = String.split(game, ";")
          if length(game_elements) == 3 do
            [team1, team2, result] = game_elements
            scores
              |> update_team_score(team1, result)
              |> update_team_score(team2, revert_result(result))
          else
            scores
          end
        end)
      teams = score_board
        |> Map.keys
        |> Enum.sort(&(compare_teams(score_board, &1, &2)))

      report = Enum.map(teams, fn team ->
          {mp, w, d, l, p} = score_board[team]
          :io_lib.format("~-31s|~3w |~3w |~3w |~3w |~3w", [team, mp, w, d, l, p])
          end)
      Enum.join([title|report], "\n")
  end

  defp score_of(scores, team) do
    {_, _, _, _, points} = scores[team]
    points
  end

  defp compare_teams(scores, team1, team2) do
    team1_points = score_of(scores, team1)
    team2_points = score_of(scores, team2)
    if team1_points == team2_points do
      team1 < team2
    else
      team1_points > team2_points
    end
  end

  defp update_team_score(scores, team, result) do
    case result do
      "win" -> 
        Map.update(scores, team, {1, 1, 0, 0, 3}, fn {mp, w, d, l, p} -> {mp+1, w+1, d, l, p+3} end)
      "loss" ->
        Map.update(scores, team, {1, 0, 0, 1, 0}, fn {mp, w, d, l, p} -> {mp+1, w, d, l+1, p} end)
      "draw" ->
        Map.update(scores, team, {1, 0, 1, 0, 1}, fn {mp, w, d, l, p} -> {mp+1, w, d+1, l, p+1} end)
      _ ->
        scores
    end
  end

  defp revert_result(result) do
    case result do
      "win" -> "loss"
      "loss" -> "win"
      "draw" -> "draw"
      _ -> ""
    end
  end

end
