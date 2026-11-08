defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    {unit, volume} = volume_pair
    volume
  end

  def to_milliliter(volume_pair) do
    {unit, volume} = volume_pair

    cond do
      unit == :cup -> {:milliliter, 240 * volume}
      unit == :fluid_ounce -> {:milliliter, 30 * volume}
      unit == :teaspoon -> {:milliliter, 5 * volume}
      unit == :tablespoon -> {:milliliter, 15 * volume}
      unit == :milliliter -> {:milliliter, volume}
    end
  end

  def from_milliliter(volume_pair, unit) do
    {:milliliter, volume_in_ml} = volume_pair

    cond do
      unit == :cup -> {:cup, volume_in_ml / 240}
      unit == :fluid_ounce -> {:fluid_ounce, volume_in_ml / 30}
      unit == :teaspoon -> {:teaspoon, volume_in_ml / 5}
      unit == :tablespoon -> {:tablespoon, volume_in_ml / 15}
      unit == :milliliter -> {:milliliter, volume_in_ml}
    end
  end

  def convert(volume_pair, unit) do
    {_, volume_in_ml} = to_milliliter(volume_pair)

    cond do
      unit == :cup -> {:cup, volume_in_ml / 240}
      unit == :fluid_ounce -> {:fluid_ounce, volume_in_ml / 30}
      unit == :teaspoon -> {:teaspoon, volume_in_ml / 5}
      unit == :tablespoon -> {:tablespoon, volume_in_ml / 15}
      unit == :milliliter -> {:milliliter, volume_in_ml}
    end
  end
end
