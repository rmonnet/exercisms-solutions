defmodule LogParser do
  def valid_line?(line) do
    String.match?(line, ~r/^\[(DEBUG|INFO|WARNING|ERROR)\]/)
  end

  def split_line(line) do
    String.split(line, ~r/<[~*=-]*>/)
  end

  def remove_artifacts(line) do
    String.replace(line, ~r/end-of-line\d+/i, "")
  end

  def tag_with_user_name(line) do
    user_name = Regex.run(~r/User\s+([^\s]+)/, line)
    if(user_name, do: "[USER] #{Enum.at(user_name, 1)} #{line}", else: line)
  end
end
