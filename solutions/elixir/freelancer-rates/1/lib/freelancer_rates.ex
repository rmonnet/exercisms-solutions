defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    8.0 * hourly_rate
  end

  def apply_discount(before_discount, discount) do
    before_discount * (1.0 - discount / 100.0)
  end

  def monthly_rate(hourly_rate, discount) do
    ceil(22 * apply_discount(daily_rate(hourly_rate), discount))
  end

  def days_in_budget(budget, hourly_rate, discount) do
    trunc(budget / apply_discount(daily_rate(hourly_rate), discount) * 10.0) / 10.0
  end
end
