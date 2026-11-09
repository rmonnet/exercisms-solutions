defmodule BirdCount do
  def today([]), do: nil
  def today([today | _]), do: today

  def increment_day_count([]), do: [1]
  def increment_day_count([today | others]), do: [today + 1 | others]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([today | others]), do: today == 0 or has_day_without_birds?(others)

  def total([]), do: 0
  def total([today | others]), do: today + total(others)

  def busy_days([]), do: 0
  def busy_days([today | others]) when today >= 5, do: 1 + busy_days(others)
  def busy_days([_ | others]), do: busy_days(others)
end
