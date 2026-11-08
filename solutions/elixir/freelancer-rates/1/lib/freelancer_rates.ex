defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    8.0 * hourly_rate
  end

  def apply_discount(before_discount, discount) do
    before_discount * (1 - discount / 100)
  end

  def monthly_rate(hourly_rate, discount) do
    ceil(22 * apply_discount(daily_rate(hourly_rate), discount))
  end

  def days_in_budget(budget, hourly_rate, discount) do
    discounted_daily_rate = hourly_rate |> daily_rate() |> apply_discount(discount)
    real_days = budget / discounted_daily_rate
    trunc(real_days * 10) / 10
  end
end
