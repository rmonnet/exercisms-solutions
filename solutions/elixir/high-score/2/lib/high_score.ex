defmodule HighScore do

  @default_score 0

  def new(), do: %{}

  def add_player(scores, name, score \\ @default_score), do: Map.put_new(scores, name, score)

  def remove_player(scores, name), do: Map.delete(scores, name)

  def reset_score(scores, name) do
    if Map.has_key?(scores, name) do
      %{scores | name => @default_score}
    else
      Map.put_new(scores, name, @default_score)
    end
  end

  def update_score(scores, name, score) do
    Map.update(scores, name, @default_score + score, &(&1 + score))
    #
    #if Map.has_key?(scores, name) do
    #  %{scores | name => score + scores[name]}
    #else
    #  Map.put_new(scores, name, @default_score + score)
    #end
  end

  def get_players(scores), do: Map.keys(scores)
end
