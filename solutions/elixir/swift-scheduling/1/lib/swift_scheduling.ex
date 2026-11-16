defmodule SwiftScheduling do
  @doc """
  Convert delivery date descriptions to actual delivery dates, based on when the meeting started.
  """
  @spec delivery_date(NaiveDateTime.t(), String.t()) :: NaiveDateTime.t()
  def delivery_date(meeting_date, description) do
    cond do
      description == "NOW" ->
        NaiveDateTime.add(meeting_date, 2, :hour)

      description == "ASAP" ->
        if before_one_pm(meeting_date) do
          meeting_date |> NaiveDateTime.beginning_of_day() |> NaiveDateTime.add(17, :hour)
        else
          meeting_date |> NaiveDateTime.beginning_of_day() |> NaiveDateTime.add(24 + 13, :hour)
        end

      description == "EOW" ->
        day_of_week = meeting_date |> NaiveDateTime.to_date() |> Date.day_of_week()

        delta =
          if day_of_week <= 3 do
            (5 - day_of_week) * 24 + 17
          else
            (7 - day_of_week) * 24 + 20
          end

        meeting_date
        |> NaiveDateTime.beginning_of_day()
        |> NaiveDateTime.add(delta, :hour)

      cmd = Regex.run(~r/(\d+)M/, description) ->
        [_, month] = cmd
        {month, _} = Integer.parse(month)

        if meeting_date.month < month do
          NaiveDateTime.new!(first_workday(meeting_date.year, month), ~T[08:00:00])
        else
          NaiveDateTime.new!(first_workday(meeting_date.year + 1, month), ~T[08:00:00])
        end

      cmd = Regex.run(~r/Q(\d+)/, description) ->
        [_, quarter] = cmd
        {quarter, _} = Integer.parse(quarter)

        if meeting_date.month <= 3 * quarter do
          NaiveDateTime.new!(last_workday_of_quarter(meeting_date.year, quarter), ~T[08:00:00])
        else
          NaiveDateTime.new!(
            last_workday_of_quarter(meeting_date.year + 1, quarter),
            ~T[08:00:00]
          )
        end
    end
  end

  def before_one_pm(meeting_date) do
    one_pm = meeting_date |> NaiveDateTime.beginning_of_day() |> NaiveDateTime.add(13, :hour)
    NaiveDateTime.compare(meeting_date, one_pm) == :lt
  end

  def first_workday(year, month) do
    first = Date.new!(year, month, 1)

    Date.range(first, Date.end_of_month(first))
    |> Enum.find(fn day -> Date.day_of_week(day) in 1..5 end)
  end

  def last_workday_of_quarter(year, quarter) do
    month = quarter * 3
    first = Date.new!(year, month, 1)

    Date.range(first, Date.end_of_month(first))
    |> Enum.reverse()
    |> Enum.find(fn day -> Date.day_of_week(day) in 1..5 end)
  end
end
