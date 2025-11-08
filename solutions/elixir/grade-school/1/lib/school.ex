defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type school :: any()

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new(), do: %{}

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    if name in roster(school) do
      {:error, school}
    else
      {:ok, Map.update(school, grade, [name], fn roster -> [name | roster] end)}
    end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
      IO.inspect(school, label: "school", charlists: :as_lists)
      IO.inspect(
      school
      |> Map.get(grade, [])
      |> Enum.sort, label: "grade=#{grade}", charlists: :as_lists)
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school) do
    grades = school |> Map.keys |> Enum.sort
    IO.inspect grades, label: "grades", charlists: :as_lists
    grades
    |> Enum.map(fn g -> grade(school, g) end)
    |> List.flatten
  end
end
