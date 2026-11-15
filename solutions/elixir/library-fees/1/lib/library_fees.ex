defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    noon = datetime |> NaiveDateTime.beginning_of_day() |> NaiveDateTime.add(12, :hour)
    NaiveDateTime.compare(datetime, noon) == :lt
  end

  def return_date(checkout_datetime) do
    lending_duration = if before_noon?(checkout_datetime), do: 28, else: 29

    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(lending_duration)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_date = NaiveDateTime.to_date(actual_return_datetime)
    max(Date.diff(actual_return_date, planned_return_date), 0)
  end

  @monday 1

  def monday?(datetime) do
    datetime |> NaiveDateTime.to_date() |> Date.day_of_week() == @monday
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_date = datetime_from_string(checkout)
    return_date = datetime_from_string(return)
    planned_return_date = return_date(checkout_date)
    actual_rate = if monday?(return_date), do: 0.5 * rate, else: rate
    fee = days_late(planned_return_date, return_date) * actual_rate
    trunc(fee)
  end
end
