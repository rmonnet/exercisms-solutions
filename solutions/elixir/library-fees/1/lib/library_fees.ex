defmodule LibraryFees do
  def datetime_from_string(string) do
    {status, datetime} = NaiveDateTime.from_iso8601(string)
    case status do
      :ok -> datetime
    end
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    today = NaiveDateTime.to_date(checkout_datetime)
    if before_noon?(checkout_datetime) do
      Date.add(today, 28)
    else
      Date.add(today, 29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_date = NaiveDateTime.to_date(actual_return_datetime)
    if Date.compare(actual_return_date, planned_return_date) == :gt do
      Date.diff(actual_return_date, planned_return_date)
    else
      0
    end
  end

  def monday?(datetime) do
    datetime |> NaiveDateTime.to_date |> Date.day_of_week == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    planned_return_date = return_date(datetime_from_string(checkout))
    actual_return_datetime = datetime_from_string(return)
    base_fee = rate * days_late(planned_return_date, actual_return_datetime)
    if(monday?(actual_return_datetime), do: trunc(base_fee * 0.5), else: base_fee)
  end
end
